require 'securerandom'
require 'tty-prompt'

def generate_password(length = 12)
  chars = [('a'..'z'), ('A'..'Z'), ('0'..'9'), '!@#$%^&*()_+-=[]{}|;:,.<>?'].map(&:to_a).flatten
  password = (0...length).map { chars[rand(chars.length)] }.join
end

prompt = TTY::Prompt.new

prompt.say("Bem-vindo ao Gerador de Senhas!")

loop do
  length = prompt.ask('Digite o comprimento da senha desejada (padrão: 12):', default: 12, convert: :int)

  password = generate_password(length)

  prompt.say("Aqui está a senha gerada: #{password}")

  choice = prompt.select('O que você gostaria de fazer?', %w(Gerar Nova Senha Sair))

  break if choice == 'Sair'

  prompt.say("\n")
end

prompt.say("Obrigado por usar o Gerador de Senhas!")
