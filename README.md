# InterSystems IRIS

## Tipos Numéricos: %Float, %Double e %Decimal
Este documento descreve os principais tipos numéricos fornecidos pelo InterSystems IRIS:  
- `%Library.Float` (deprecated)  
- `%Library.Double`  
- `%Library.Decimal`

---

## 🔹 Estrutura do Projeto e Código

Este repositório contém exemplos práticos em ObjectScript para demonstrar diferenças de comportamento e performance entre `%Float`, `%Double` e `%Decimal`.

- `src/IEEE/ExampleNumber.cls`
- `src/IEEE/SumFloat.cls`
- `src/IEEE/SumDouble.cls`
- `src/IEEE/SumDecimal.cls`
- `src/IEEE/SumDecimalWithScale.cls`
- `src/IEEE/Benchmark.cls`

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

## 🔹 Como Executar os Exemplos

Abra um terminal do IRIS (ou use o painel do VS Code com a extensão InterSystems) e troque para o namespace apropriado.

### Executar demonstrações rápidas

```objectscript
; Exibir diferenças de armazenamento entre tipos
do ##class(IEEE.ExampleNumber).Demo(123.456789)

; Exemplos de soma por tipo
do ##class(IEEE.SumFloat).execExample()
do ##class(IEEE.SumDouble).execExample()
do ##class(IEEE.SumDecimal).execExample()
do ##class(IEEE.SumDecimalWithScale).execExample()
```

### Executar benchmarks individuais

```objectscript
; Ajuste o parâmetro length conforme necessário
do ##class(IEEE.SumFloat).Benchmark(50000)
do ##class(IEEE.SumDouble).Benchmark(500000)
do ##class(IEEE.SumDecimalWithScale).Benchmark(50000)
```

### Executar a suíte de benchmark orquestrada

```objectscript
do ##class(IEEE.Benchmark).execute(100000)
```

> Dica: rode cada benchmark mais de uma vez para aquecer caches e reduzir variação. Execute em ambiente estável (sem outras cargas) para resultados mais consistentes.

---

## 🔹 Interpretação dos Resultados

- Os números da seção de benchmark são ilustrativos e variam por hardware, carga do servidor e versão do IRIS.
- `%Double` segue IEEE 754: use tolerância ao comparar valores e cuidado com `==` direto.
- `%Decimal` respeita `SCALE`: ideal para somas de dinheiro e totais exatos.
- `%Float` é legado e pode diferir em limites/arredondamentos; evite em código novo.

---

## 🔹 Dicas Práticas

- Use `%Decimal` para domínios financeiros ou quando 0.1 + 0.2 deve ser exatamente 0.3.
- Use `%Double` para cálculos científicos e estatísticos onde a performance e a ampla faixa dinâmica são mais importantes do que a exatidão decimal.
- Evite `%Float` em novos desenvolvimentos; migre classes existentes para `%Double` ou `%Decimal` conforme o caso.
- Controle a exibição com `FORMAT`/`SCALE`, mas lembre-se: `SCALE` em `%Double` e `%Float` afeta exibição, não a precisão interna.

---

## 🔹 Referências úteis

- Documentação InterSystems IRIS: `%Library.Double`, `%Library.Decimal`, `%Library.Float` (deprecated)
- Padrão IEEE 754 (double-precision): arredondamento e representação


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
Cada tipo executou **1 milhão de cálculos** em **10 execuções distintas**.  
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
