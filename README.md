# InterSystems IRIS

## 📊 Tipos Numéricos: %Float, %Double e %Decimal

### 🎯 Objetivo do Projeto

Este repositório demonstra de forma prática as diferenças entre os principais tipos numéricos do InterSystems IRIS através de exemplos executáveis e benchmarks de performance. O projeto visa ajudar desenvolvedores a escolher o tipo numérico mais adequado para cada situação.

### 📋 Tipos Numéricos Disponíveis

O InterSystems IRIS oferece três tipos numéricos principais:

- **`%Library.Float`** (deprecated) - Ponto flutuante legado
- **`%Library.Double`** - Ponto flutuante IEEE 754 (64 bits)  
- **`%Library.Decimal`** - Ponto fixo decimal exato

### 🚀 Início Rápido

Para começar imediatamente, execute no terminal IRIS:

```objectscript
; Demonstração rápida das diferenças
do ##class(IEEE.ExampleNumber).Demo(123.456789)

; Exemplos de soma por tipo
do ##class(IEEE.SumFloat).execExample()
do ##class(IEEE.SumDouble).execExample()
do ##class(IEEE.SumDecimal).execExample()
```

---

## 📁 Estrutura do Projeto

### Arquivos do Projeto

```
src/IEEE/
├── ExampleNumber.cls          # Demonstração de armazenamento por tipo
├── SumFloat.cls              # Operações com %Float
├── SumDouble.cls             # Operações com %Double  
├── SumDecimal.cls            # Operações com %Decimal básico
├── SumDecimalWithScale.cls   # Operações com %Decimal controlado
└── Benchmark.cls             # Orquestrador de benchmarks
```

### Classes e Responsabilidades

- `IEEE.ExampleNumber`
  - Demonstra o armazenamento de um mesmo valor em três propriedades: `%Float`, `%Double` e `%Decimal(SCALE=10)`.
  - Método `Demo(value)` cria um registro e imprime os valores armazenados, evidenciando diferenças de exibição/precisão.

- `IEEE.SumFloat`
  - Modelo simples com propriedades `%Float` (`sum1`, `sum2`, `result`).
  - `calculate(sum1, sum2)`: soma dois `%Float` e retorna o objeto.
  - `execExample()`: exemplo rápido imprimindo `0.2 + 0.1` e o objeto resultante (via `zwrite`).
  - `Benchmark(length=50000)`: executa várias somas usando `%Float` e relata o tempo.

- `IEEE.SumDouble`
  - Modelo com `%Double` (`sum1`, `sum2`, `result`).
  - `calculate(sum1, sum2)`: soma dois `%Double` e retorna o objeto.
  - `execExample()`: exemplo com `$double(0.2) + $double(0.1)`.
  - `Benchmark(length=500000)`: executa o benchmark usando `%Double` com amostra maior por padrão.

- `IEEE.SumDecimal`
  - Modelo com `%Decimal` sem escala explícita (`sum1`, `sum2`, `result`).
  - `calculate(sum1, sum2)`: soma dois `%Decimal`, persiste e imprime o resultado.
  - `execExample()`: demonstra `0.2 + 0.1` com `%Decimal` (exato).

- `IEEE.SumDecimalWithScale`
  - Modelo com `%Decimal(SCALE=10)` para `sum1` e `sum2`, e `result` com `SCALE=4`.
  - `calculate(sum1, sum2)`: soma com controle explícito de escala e retorna o objeto (sem persistir por padrão).
  - `execExample()`: imprime exemplo e o objeto via `zwrite`.
  - `Benchmark(length=50000)`: benchmark com `%Decimal` controlando escala.

- `IEEE.Benchmark`
  - Orquestra a execução dos benchmarks das classes acima em sequência, intercalando `KillExtent` para isolar medições.

> Observação sobre persistência: as classes estendem `%Persistent`. Alguns métodos de exemplo comentam a chamada `%Save()` para evitar I/O durante benchmarks. Os métodos `KillExtent()` removem registros entre execuções para reduzir interferências.

---

## ⚡ Como Executar os Exemplos

### Pré-requisitos

- InterSystems IRIS instalado e configurado
- Namespace apropriado configurado
- Classes compiladas no namespace

### 🎮 Demonstrações Interativas

#### 1. Comparação de Armazenamento
```objectscript
; Demonstra como o mesmo valor é armazenado em cada tipo
do ##class(IEEE.ExampleNumber).Demo(123.456789)
```

#### 2. Exemplos de Soma por Tipo
```objectscript
; Teste o famoso caso 0.1 + 0.2 em cada tipo
do ##class(IEEE.SumFloat).execExample()      ; %Float (legado)
do ##class(IEEE.SumDouble).execExample()     ; %Double (IEEE 754)
do ##class(IEEE.SumDecimal).execExample()    ; %Decimal (exato)
do ##class(IEEE.SumDecimalWithScale).execExample() ; %Decimal com escala
```

### 📊 Benchmarks de Performance

#### Benchmarks Individuais
```objectscript
; Execute cada tipo separadamente
do ##class(IEEE.SumFloat).Benchmark(50000)           ; %Float
do ##class(IEEE.SumDouble).Benchmark(500000)         ; %Double (maior amostra)
do ##class(IEEE.SumDecimalWithScale).Benchmark(50000) ; %Decimal
```

#### Suíte Completa de Benchmarks
```objectscript
; Executa todos os benchmarks em sequência com isolamento
do ##class(IEEE.Benchmark).execute(100000)
```

> 💡 **Dicas de Performance**: Execute benchmarks múltiplas vezes para aquecer caches e obtenha resultados mais consistentes em ambiente estável.

---

## 📈 Interpretação dos Resultados

### Resultados de Benchmark
- ⚠️ **Importante**: Os tempos são ilustrativos e variam conforme hardware, carga do servidor e versão do IRIS
- `%Decimal` pode ser mais rápido em alguns cenários devido à otimização interna
- `%Double` oferece melhor consistência de performance
- `%Float` apresenta comportamento imprevisível (evitar uso)

### Comportamento Esperado
- **`%Double`**: Segue IEEE 754 - use tolerância em comparações (`epsilon`)
- **`%Decimal`**: Respeita `SCALE` - ideal para cálculos monetários exatos
- **`%Float`**: Comportamento inconsistente - migrar para `%Double` ou `%Decimal`

---

## 💡 Guia de Escolha de Tipos

### Quando Usar Cada Tipo

| Cenário | Tipo Recomendado | Motivo |
|---------|------------------|--------|
| 💰 **Cálculos Financeiros** | `%Decimal(SCALE=2)` | Precisão decimal exata |
| 🧮 **Cálculos Científicos** | `%Double` | Amplo range, performance |
| 📊 **Estatísticas/ML** | `%Double` | IEEE 754 padrão |
| 🏦 **Sistemas Bancários** | `%Decimal` | Conformidade regulatória |
| ⚡ **Performance Crítica** | `%Double` | Otimização de hardware |

### ⚠️ Armadilhas Comuns

- **Nunca use `==` com `%Double`** - use tolerância: `$zabs(a-b) < epsilon`
- **`%Float` é deprecated** - migre código existente
- **`SCALE` em `%Double`** afeta apenas exibição, não precisão interna
- **Conversões implícitas** podem causar perda de precisão

---

## 📚 Referências e Documentação

### Documentação Oficial InterSystems
- [`%Library.Double`](https://docs.intersystems.com/irisforhealthlatest/csp/docbook/DocBook.UI.Page.cls?KEY=GOBJ_datatypes#GOBJ_datatypes_double) - Ponto flutuante IEEE 754
- [`%Library.Decimal`](https://docs.intersystems.com/irisforhealthlatest/csp/docbook/DocBook.UI.Page.cls?KEY=GOBJ_datatypes#GOBJ_datatypes_decimal) - Ponto fixo decimal
- [`%Library.Float`](https://docs.intersystems.com/irisforhealthlatest/csp/docbook/DocBook.UI.Page.cls?KEY=GOBJ_datatypes#GOBJ_datatypes_float) - Deprecated

### Padrões e Especificações
- [IEEE 754-2019](https://ieeexplore.ieee.org/document/8766229) - Padrão de ponto flutuante
- [Decimal Arithmetic](https://speleotrove.com/decimal/) - Aritmética decimal exata


## 🔹 %Library.Float (Deprecated)

**Classe:** `%Library.Float`  
**Superclasse:** `%Library.DataType`  
**Tipo ODBC:** `DOUBLE`  

**Descrição:**  
Representa um número em ponto flutuante.  
> **Observação**: Esta classe está **obsoleta** e não deve ser mais utilizada.  

### 🚫 Limitações
- Diferente do `%Double`, o `%Float` **não é totalmente compatível com o padrão IEEE 754 (double-precision)**.  
- Foi mantido por compatibilidade com sistemas mais antigos, mas pode apresentar diferenças em arredondamento, normalização e limites.  
- Por isso, a InterSystems recomenda substituí-lo por:
  - **`%Double`** → para cálculos científicos/matemáticos (ponto flutuante IEEE 754).  
  - **`%Decimal`** → para cálculos que exigem exatidão decimal (financeiro, contábil, monetário).  

### Métodos Principais
- `DisplayToLogical()`
- `IsValid()`
- `LogicalToDisplay()`
- `LogicalToJSON()`
- `Normalize()`
- `XSDToLogical()`

### Parâmetros
- `DISPLAYLIST`, `VALUELIST`
- `FORMAT` (usa `$FNUMBER`)
- `SCALE` (número de casas decimais na exibição, mas não garante exatidão IEEE)
- `XSDTYPE = double`

---

## 🔹 %Library.Double

**Classe:** `%Library.Double`  
**Superclasse:** `%Library.DataType`  
**Tipo ODBC:** `DOUBLE`  

**Descrição:**  
Representa um número de **ponto flutuante em precisão dupla (64 bits, IEEE 754)**.  
Usado para cálculos científicos, matemáticos e em situações onde a performance é mais importante que a exatidão decimal.

### Características
- Compatível com **IEEE 754**.  
- Regras de arredondamento: *round to nearest, ties to even* (Banker’s rounding).  
- Precisão de aproximadamente **15–16 dígitos decimais**.  
- Sujeito a erros de representação binária (`0.1 + 0.2 = 0.30000000000000004`).  

### Métodos Principais
- `DisplayToLogical()`
- `IsValid()`
- `JSONToLogical()`
- `LogicalToDisplay()`
- `LogicalToJSON()`
- `LogicalToXSD()`
- `Normalize()`
- `OdbcToLogical()`
- `XSDToLogical()`

### Parâmetros
- `DISPLAYLIST`, `VALUELIST`
- `FORMAT` (usa `$FNUMBER`)
- `SCALE` (apenas afeta exibição, não a precisão binária)
- `XSDTYPE = double`

---

## 🔹 %Library.Decimal

**Classe:** `%Library.Decimal`  
**Superclasse:** `%Library.DataType`  
**Tipo ODBC:** `NUMERIC`  

**Descrição:**  
Representa um **número em ponto fixo (decimal exato)**.  
É a melhor escolha para **cálculos financeiros, monetários e contábeis**, pois não sofre com os erros de representação binária do `%Double`.

### Características
- Não utiliza IEEE 754, mas sim **aritmética decimal exata**.  
- Precisão e arredondamento definidos pelo parâmetro `SCALE`.  
- Exemplo: `%Decimal(SCALE=2)` → sempre arredonda para duas casas decimais.  

### Métodos Principais
- `DisplayToLogical()`
- `IsValid()`
- `LogicalToDisplay()`
- `LogicalToJSON()`
- `Normalize()`
- `XSDToLogical()`

### Parâmetros
- `DISPLAYLIST`, `VALUELIST`
- `FORMAT` (usa `$FNUMBER` ou `"AUTO"`)
- `SCALE` (define número de casas decimais exatas)
- `XSDTYPE = decimal`

---

## 🔹 Diferenças Principais

| Tipo        | Representação       | Precisão          | Uso Recomendado                          |
|-------------|---------------------|-------------------|------------------------------------------|
| `%Float`    | Ponto flutuante antigo (não-IEEE) | Menor precisão, se aplicado o 32 bits | Não usar (substituir por `%Double` ou `%Decimal`). |
| `%Double`   | Ponto flutuante (64 bits, IEEE 754) | Alta, ~15–16 dígitos decimais | Cálculos científicos, matemáticos, estatísticos. |
| `%Decimal`  | Ponto fixo (exato)  | Definida pelo `SCALE` | Financeiro, monetário, contábil (onde 0.1 + 0.2 = 0.3 de forma exata). |

---

## 🔹 Regras de Arredondamento

- **IEEE 754 (para `%Double`)**:  
  - Default: *round to nearest, ties to even* (Banker’s rounding).  
  - Comparações devem usar tolerância (`epsilon`).  

- **%Decimal**:  
  - Respeita o `SCALE`.  
  - Exemplo: `%Decimal(SCALE = 2)` arredonda automaticamente para 2 casas decimais.  
  - Pode usar `$FNUMBER` para formatação de saída.

---

## 🔹 Benchmark de Performance

Foi implementado um teste para comparar a performance de `%Float`, `%Double` e `%Decimal`.  
Cada tipo executou **100 mil de cálculos** em **10 execuções distintas**.  
A tabela a seguir resume os tempos medidos:

| Tipo      | Tempo mínimo | Tempo máximo | Tempo médio |
|-----------|-------------:|-------------:|------------:|
| %Float    | 0,21s        | 0,30s        | 0,24s       |
| %Double   | 0,22s        | 0,27s        | 0,24s       |
| %Decimal  | 0,19s        | 0,29s        | 0,21s       |

📌 **Observações:**  
- O `%Decimal` mostrou-se **ligeiramente mais rápido em média** neste benchmark, apesar de ser considerado mais “pesado” em cálculos matemáticos devido ao controle de escala e arredondamento.  
- `%Float` e `%Double` tiveram tempos muito próximos, com o `%Double` apresentando menos variação.  
- A escolha deve considerar **o contexto**: performance vs exatidão.  

---
