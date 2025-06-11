# 📝 Aplicativo Lista de Tarefas (To-Do List) em Flutter

Este é um aplicativo de lista de tarefas desenvolvido em Flutter como parte de um processo de aprendizado e construção de portfólio, com foco na implementação de funcionalidades CRUD (Create, Read, Update, Delete) e persistência de dados local utilizando SQLite.

## ✨ Funcionalidades Implementadas (Fase 1 - Concluída)

* **Criação de Tarefas:** Adicionar novas tarefas à lista.
* **Visualização de Tarefas:** Exibir a lista de tarefas pendentes e concluídas.
* **Atualização de Tarefas:** Marcar/Desmarcar tarefas como concluídas.
* **Exclusão de Tarefas:** Remover tarefas da lista com diálogo de confirmação.
* **Persistência de Dados:** Todas as tarefas e seus status são salvos localmente em um banco de dados SQLite, garantindo que os dados não se percam ao fechar o aplicativo.


### Fase 2: Arquitetura com Provider (Concluída)
  * **Gerenciamento de Estado Profissional:** Refatoração completa da lógica de estado utilizando o pacote `provider`.
  * **Separação de Responsabilidades:** A lógica de negócio (gerenciamento de tarefas, interação com o banco de dados) foi movida para uma classe `TasksProvider`, desacoplando-a da interface do usuário.
  * **Código Mais Limpo e Escalável:** Adoção de uma arquitetura que torna o código mais organizado, fácil de testar e pronto para futuras expansões.

### Fase 3: Melhorias de UI/UX (Em Andamento)
* **Interface com Abas:** Criação de uma UI com `TabBar` e `TabBarView` para separar visualmente as tarefas "Pendentes" das "Concluídas", melhorando a organização e a experiência do usuário.
* **Filtro de Tarefas Concluídas:** A aba "Concluídas" exibe apenas as tarefas finalizadas no último mês, mantendo a interface limpa e focada em atividades recentes.

## 📸 GIF

<!-- Uploading "Screen_recording_20250611_041829-ezgif.com-resize.gif"... -->

## 🛠️ Tecnologias Utilizadas

* **Flutter:** Framework principal para o desenvolvimento da interface e lógica do app.
* **Dart:** Linguagem de programação utilizada pelo Flutter.
* **SQLite (`sqflite`):** Para persistência de dados local, armazenando as tarefas diretamente no dispositivo.
* **`path_provider`:** Para encontrar o caminho correto no sistema de arquivos para armazenar o banco de dados.
* **`path`:** Utilitário para manipulação de caminhos de arquivos.
* **Material Design 3:** Para os componentes visuais e tema do aplicativo.
* **Provider:** Para gerenciamento de estado centralizado e injeção de dependência, seguindo as melhores práticas recomendadas pela comunidade Flutter.

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
* **Gerenciamento de Estado Avançado com Provider:**
  * Implementação do padrão `ChangeNotifier` e uso do widget `ChangeNotifierProvider` para disponibilizar o estado das tarefas de forma eficiente para a árvore de widgets.
  * Utilização de `context.watch<TasksProvider>()` para "ouvir" as mudanças de estado na UI e disparar reconstruções automáticas.
  * Utilização de `context.read<TasksProvider>()` para chamar métodos e lógicas do provider a partir de callbacks de eventos (como cliques em botões), sem causar reconstruções desnecessárias do widget que disparou a ação.
  * Prática da separação clara entre a lógica de negócio (agora no `TasksProvider`) e a camada de apresentação (os widgets), resultando em um código significativamente mais organizado e desacoplado.
* **Criação de Modelos de Dados:** Implementação da classe `Task` para representar os dados de forma tipada e organizada, melhorando a clareza e a segurança do código em comparação com o uso direto de `Map<String, dynamic>`.
* **Construção de UI com Abas:** Implementação de uma interface navegável utilizando o `DefaultTabController`, `TabBar` (dentro do `AppBar`) e `TabBarView` para criar uma experiência de usuário fluida e organizada.
* **Filtragem de Dados no Provider:** Criação de `getters` computados no `TasksProvider` (ex: `pendingTasks`, `recentCompletedTasks`) para fornecer listas de dados já filtradas para a UI. Esta técnica mantém a lógica de negócio fora da camada de visualização e otimiza a reatividade da interface.
* **Refatoração e Composição de Widgets:** Extração da lógica da lista de tarefas para um widget reutilizável (`TasksListView`), promovendo um código mais limpo, evitando duplicação e seguindo o princípio de composição do Flutter.
* **Migração de Banco de Dados (`sqflite`):** Atualização do schema do banco de dados `SQLite` em uma base já existente para adicionar novas colunas (`completionDate`). Isso foi feito de forma segura incrementando a `version` do banco e utilizando o callback `onUpgrade` para aplicar as alterações com `ALTER TABLE`.

## 📈 Roadmap de Evolução (Próximas Fases Planejadas)

Este projeto é a base para futuras melhorias e aprendizados:

* **Fase 1: Fundação de Dados com SQL (✅ Concluída)**
* **Fase 2: MVP Profissional (Provider e Arquitetura) (✅ Concluída)**
* **Fase 3: Melhorias de UI/UX:** Adicionar busca de tarefas, abas para "Pendentes" e "Concluídas", datas de conclusão com indicadores visuais de prazo e modo escuro. (⏳ Em Andamento)**
* **Fase 4: Testes Automatizados:** Escrever testes de unidade e de widget.
* **Fase 5: Sincronização com a Nuvem (API):** Conectar o app a uma API (como JSONPlaceholder para simulação) para buscar e enviar tarefas, permitindo uma experiência "offline-first".

## 👨‍💻 Autor

* **[Pedrokidev]**
* LinkedIn: `[https://www.linkedin.com/in/pedro-carvalho-de-oliveira-291228175/]`
* GitHub: `[https://github.com/PedrokiDev]`

---
