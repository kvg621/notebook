# encoding: utf-8
# (с) 2015 goodprogrammer.ru
# Программа "Блокнот"

require 'twitter'

class Tweet < Post

  @@CLIENT = Twitter::REST::Client.new do |config|
    # ВНИМАНИЕ! Эти параметры уникальны для каждого проиложения, вы должны
    # зарегистрировать в своем аккаунте новое приложение на https://apps.twitter.com
    # и взять со страницы этого приложения данные настройки!
    config.consumer_key = 'VfRFbx13bEpss8i88wf27zUXY'
    config.consumer_secret = 'nq58OGnq0G7cL1u4Na7AA0j90m33nQpYYj3X2qz0p339kOgHpq'
    config.access_token = '14079676-mza5y4JuQBz7NWROzVOfqi1nXybkwFbrVoNjODyzc'
    config.access_token_secret = 'MkWqpcOYN2reeBD7S2HDfVLXjQHEHWfvy9VVkaIayi7Oe'
  end

  def read_from_console
    puts 'Новый твит (140 символов!):'

    @text = STDIN.gets.chomp[0..140]

    puts "Отправляем ваш твит: #{@text.encode('utf-8')}"
    @@CLIENT.update(@text.encode('utf-8'))
    puts 'Твит отправлен.'
  end


  # Массив из даты создания + тело твита
  def to_strings
    time_string = "Создано: #{@created_at.strftime('%Y.%m.%d, %H:%M:%S')} \n\r \n\r"

    #  добавляем в массив текста в начало строчку времени и возвращаем
    return [time_string, @text]
  end

  def to_db_hash
    # вызываем родительский метод ключевым словом super и к хэшу, который он вернул
    # присоединяем прицепом специфичные для этого класса поля методом Hash#merge
    return super.merge(
        {
            'text' => @text # наш твит
        }
    )
  end

# загружаем свои поля из хэш массива
  def load_data(data_hash)
    super(data_hash) # сперва дергаем родительский метод для общих полей

    # теперь прописываем свое специфичное поле
    @text = data_hash['text']
  end
end
