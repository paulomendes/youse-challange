# Youse Challenge

# Setup

Install bundle dependecies
```sh
bundle install
```
Install App Dependencies
```sh
bundle exec pod install
```

Run Unit Tests
```sh
bundle exec fastlane ios test
```

Show Coverage Tests Report
```sh
bundle exec fastlane ios coverage
```



![module architecture](https://raw.githubusercontent.com/paulomendes/youse-challenge/master/module-architecture.png)

## Arquitetura do App

Este app usa uma arquitetura baseada no RIBs (https://github.com/uber/RIBs), entretanto simplificada mas que mantém todos os conceitos do SOLID. Proporcionando uma arquitetura altamente testável e adaptável. O principal conceito é que geralmente não é necessário todos os componentes para que seja criado um módulo. Um módulo pode ou ter uma `ViewController` ou um `Presenter` ou um `Interactor` (este que foi suprimido de propósito em favor da simplicidade do código)

### `Module` (Builder)

Ele é responsável por buildar todos os componentes do modulo. Desse modo ele tem a responsabilidade de gerenciar as dependências do modulo como um todo facilitado o gerenciamento de injeção de dependência.

### `Router`

Ele é responsável por manter a referência do módulo como um todo. Com isso ele tem a capacidade de `attach` ou `detach` outros routers da memória além de apresentá-los da `UIWindow` da aplicação.

### `Presenter`

Responsável pelo acesso aos dados e repasse para a `ViewController` que apresentará os dados. Suas dependências serão qualquer tipo de repositório de dados. No caso estou tratando o GPS como um repositório de dados também. Nesse app o `Presenter` também tem a função do `Interactor` feita de propósito pois as interações do usuário com o aplicativo eram simples e não requeriam uma nova camada de abstração.

### `ViewController` (View + ViewController)

Responsável pela apresentação dos dados ao usuário e também recebe os inputs que o usuário faz e os repassa para o `Presenter`.

## Arquitetura dos Dados

O app faz uso do `Repository Pattern`. Todo dado externo é tratado como um repositório. Tanto uma chamada de API como a localização de um GPS.

## PODs

### Moya

Lib para abstração das requests do app. Ele depende do `Alamofire`. A abstração do `Moya` faz com que todas as requests do app saiam apenas de um lugar, e também facilita o teste unitário pois cada `API` é configurável a partir de um `Target`

### INTULocationManager

Um wrapper do `CLLocationManager` que abstrai todas as chamadas de delegate para blocos facilitando a adapação ao `Repository Pattern`.

### SwiftResolver

Uma lib que ajudei a criar para gerenciamento de dependência simples. Criamos essa lib enquanto trabalhávamos na 99. Usei ela por ser exatamente o que precisava para o momento.

### JGProgressHUD

Um facilitador para apresentar progresso para o usuário durante as chamadas de API

### Quick e Nimble

Para facilitar a leitura dos testes unitários
