require 'securerandom'
require 'tty-prompt'
require 'pastel'

# Inicializa o objeto Pastel para estilizar o texto com cores
pastel = Pastel.new

def generate_password(length = 12, include_numbers = true, include_special_chars = true)
  lowercase_letters = ('a'..'z').to_a
  uppercase_letters = ('A'..'Z').to_a
  digits = ('0'..'9').to_a
  special_characters = '!@#$%^&*()_+-=[]{}|;:,.<>?'.chars
  
  all_chars = lowercase_letters + uppercase_letters
  all_chars += digits if include_numbers
  all_chars += special_characters if include_special_chars
  
  password = SecureRandom.base64(length).tr('+/=', all_chars[rand(all_chars.length)])
end

prompt = TTY::Prompt.new

# Mensagem de boas-vindas com cor verde
puts pastel.green("Bem-vindo ao Gerador de Senhas!")

loop do
  length = prompt.ask('Digite o comprimento da senha desejada (máximo: 20):', default: 20, convert: :int) do |q|
    q.in('1-20')  # Restringe o input entre 1 e 20 caracteres
  end

  # Converte length para 20 se for maior que 20 e alerta o usuário
  if length > 20
    puts pastel.red("O comprimento máximo permitido é 20. Configurando para 20 caracteres.")
    length = 20
  end

  include_numbers = prompt.yes?('Incluir números na senha?')

  include_special_chars = prompt.yes?('Incluir caracteres especiais na senha?')

  password = generate_password(length, include_numbers, include_special_chars)

  # Exibe a senha gerada em amarelo
  puts pastel.yellow("Aqui está a senha gerada: #{password}")

  # Opção "Gerar Nova Senha" em uma linha só
  choice = prompt.select('O que você gostaria de fazer?', %w(Gerar\ Nova\ Senha Sair), per_page: 2)

  break if choice == 'Sair'

  puts "\n"
end

# Mensagem de despedida em azul
puts pastel.blue("Obrigado por usar o Gerador de Senhas!")
