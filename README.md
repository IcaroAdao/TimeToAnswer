# TimeToAnswer

Quiz com perguntas e respostas, onde cada pergunta está relacionada à um assunto diverso. O projeto foi desenvolvido como parte do curso [Ruby on Rails 5.x - Do início ao fim!](https://www.udemy.com/course/rubyonrails-5x/) ministrado pelo [Jackson Pires](https://www.linkedin.com/in/jackson-pires/).

## Requisitos

* Ruby 2.4.4
* Rails 5.2.0

## Instruções

Para acessar a aplicação é necessário fazer o clone da mesma:

```console
git clone https://github.com/IcaroAdao/TimeToAnswer.git
```
Dentro da pasta do projeto é necessário instalar as dependências do projeto:

```console
bundle install
npm i
```

Em seguida, ainda dentro da pasta do projeto, basta inicializar a aplicação:

```console
rails s
```

## Detalhes da Aplicação

Nessa seção serão abordados alguns detalhes sobre as duas áreas de acessos existentes na aplicação.

### Área dos usuários

A parte do usuário permite responder as perguntas do quiz e ver estatísticas sobre os erros e acertos, bem como o número total de perguntas respondidas.

#### Rota de login dos usuários:

host/users/sign_in

#### Usuário padrão para login:

user@user.com

123456

### Área administrativa

Na parte administrativa é possível adicionar novos assuntos e formular peguntas baseada nesses assuntos, um exemplo de assunto seria Veterinária ou Informática. Também é possível consultar estatísticas sobre o sistema e adicionar outros administradores.

#### Rota de login para administradores:

host/backoffice

#### Administrador padrão para login:

admin@admin.com

123456
