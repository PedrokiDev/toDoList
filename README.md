# 📝 Aplicativo Lista de Tarefas (To-Do List) em Flutter

Este é um aplicativo de lista de tarefas desenvolvido em Flutter como parte de um processo de aprendizado e construção de portfólio, com foco na implementação de funcionalidades CRUD (Create, Read, Update, Delete) e persistência de dados local utilizando SQLite.

## ✨ Funcionalidades Implementadas (Fase 1 - Concluída)

* **Criação de Tarefas:** Adicionar novas tarefas à lista.
* **Visualização de Tarefas:** Exibir a lista de tarefas pendentes e concluídas.
* **Atualização de Tarefas:** Marcar/Desmarcar tarefas como concluídas.
* **Exclusão de Tarefas:** Remover tarefas da lista com diálogo de confirmação.
* **Persistência de Dados:** Todas as tarefas e seus status são salvos localmente em um banco de dados SQLite, garantindo que os dados não se percam ao fechar o aplicativo.

## 📸 GIF

(![Image](https://github.com/user-attachments/assets/eb98cdec-3582-467d-aaef-2baa83aa2c3c))

## 🛠️ Tecnologias Utilizadas

* **Flutter:** Framework principal para o desenvolvimento da interface e lógica do app.
* **Dart:** Linguagem de programação utilizada pelo Flutter.
* **SQLite (`sqflite`):** Para persistência de dados local, armazenando as tarefas diretamente no dispositivo.
* **`path_provider`:** Para encontrar o caminho correto no sistema de arquivos para armazenar o banco de dados.
* **`path`:** Utilitário para manipulação de caminhos de arquivos.
* **Material Design 3:** Para os componentes visuais e tema do aplicativo.

## 🚀 Jornada de Desenvolvimento e Aprendizados

Este projeto foi desenvolvido com foco em solidificar conceitos fundamentais do Flutter e do desenvolvimento mobile. Alguns dos principais aprendizados e desafios superados incluem:

* **Configuração do Ambiente e Estrutura Inicial:** Criação do projeto e organização básica dos widgets.
* **Gerenciamento de Estado Básico:** Utilização de `StatefulWidget` e a função `setState` para gerenciar o estado da lista de tarefas e atualizar a interface do usuário dinamicamente.
* **Persistência de Dados com SQLite:**
    * Criação e gerenciamento de um banco de dados local usando o plugin `sqflite`.
    * Definição do schema da tabela `tasks`.
    * Implementação das operações CRUD (Create, Read, Update, Delete) no `DatabaseHelper`.
* **Resolução de Bugs e Depuração:**
    * Identificação e correção de erros de digitação em nomes de tabelas e colunas (`task` vs `tasks`, `idDone` vs `isDone`).
    * Entendimento e solução do erro `No MaterialLocalizations found` ao usar `showDialog`, através da utilização correta do `BuildContext` com o widget `Builder`.
    * Diagnóstico e correção do erro `Unsupported operation: read-only` ao tentar modificar mapas imutáveis retornados pelo `sqflite`, implementando a criação de cópias mutáveis.
    * Resolução de `RangeError` durante a exclusão de itens, otimizando o fluxo de atualização da UI e manipulação da lista.
* **Construção de UI com Flutter:** Utilização de `ListView.builder`, `ListTile`, `Checkbox`, `IconButton`, `FloatingActionButton`, `AlertDialog` e `TextField`.
* **Boas Práticas:** Organização do código com uma classe `DatabaseHelper` separada, uso de `async/await` para operações assíncronas.

## 📈 Roadmap de Evolução (Próximas Fases Planejadas)

Este projeto é a base para futuras melhorias e aprendizados:

* **Fase 1: Fundação de Dados com SQL (✅ Concluída)**
* **Fase 2: MVP Profissional (Provider e Arquitetura):** Implementar o Provider para um gerenciamento de estado mais robusto e desacoplado da UI.
* **Fase 3: Melhorias de UI/UX:** Adicionar busca de tarefas, abas para "Pendentes" e "Concluídas", datas de conclusão com indicadores visuais de prazo e modo escuro.
* **Fase 4: Testes Automatizados:** Escrever testes de unidade e de widget.
* **Fase 5: Sincronização com a Nuvem (API):** Conectar o app a uma API (como JSONPlaceholder para simulação) para buscar e enviar tarefas, permitindo uma experiência "offline-first".

## 👨‍💻 Autor

* **[Pedrokidev]**
* LinkedIn: `[https://www.linkedin.com/in/pedro-carvalho-de-oliveira-291228175/]`
* GitHub: `[https://github.com/PedrokiDev]`

---