require 'date'
# Класс «Задача», разновидность базового класса «Запись»
class Task < Post
  # Конструктор у класса «Задача» свой, но использует конструктор родителя.
  def initialize
    # Вызываем конструктор родителя
    super

    # Создаем специфичную для ссылки переменную экземпляра @due_date — время, к
    # которому задачу нужно выполнить
    @due_date = Time.now
    @event = 'deadline'
  end

  # Напишем реализацию метода read_from_console для экземпляра задачи. Он
  # спрашивает у пользователя текст задачи (что нужно сделать) и дату, до
  # которой нужно успеть это сделать.
  def read_from_console
    # Спросим у пользователя, что нужно сделать и запишем его ответ (строку) в
    # переменную экземпляра класса Задача @text.
    puts 'Что надо сделать?'
    @text = $stdin.gets.chomp

    # Спросим у пользователя, до какого числа ему нужно выполнить задачу и
    # подскажем формат, в котором нужно вводить дату. А потом запишем его ответ
    # в локальную переменную input.
    puts 'К какому числу? Укажите дату в формате ДД.ММ.ГГГГ, ' \
         'например 12.05.2003'
    input = $stdin.gets.chomp

    # Для того, чтобы из строки получить объект класса Date, с которым очень
    # удобно работать (например, можно вычислить, сколько осталось дней до
    # нужной даты), мы получим этот объект из строки с помощью метода класса
    # Date (статического метода).
    @due_date = Date.parse(input)
  end

  # сколько времени осталось до нужной даты. Этот метод дает обратный отсчет дней,
  # часов, минут и секунд до запланированного события:
  def remaining
    return_data = @due_date.strftime('%d.%m.%Y')
    reverse_data = return_data.split('.').map(&:to_i).reverse

    date = DateTime.new(reverse_data[0], reverse_data[1], reverse_data[2], DateTime.now.offset)

    intervals = [['day', 1], ['hour', 24], ['minute', 60], ['second', 60]]

    elapsed = DateTime.now - date
    tense = elapsed.positive? ? 'since' : 'until'

    interval = 1.0
    parts = intervals.collect do |name, new_interval|
      interval /= new_interval
      number, elapsed = elapsed.abs.divmod(interval)
      "#{number.to_i} #{name}#{'s' unless number == 1}"
    end

    "#{parts.join(', ')} #{tense} #{@event}."
  end

  # Метод to_string должен вернуть все строки, которые мы хотим записать в
  # файл при записи нашей задачи: строку с дедлайном, описание задачи и дату
  # создания задачи.
  def to_strings
    deadline = "Крайний срок: #{@due_date.strftime('%Y.%m.%d')}"
    time_string = "Создано: #{@created_at.strftime('%Y.%m.%d, %H:%M:%S')} \n"
    [deadline, remaining, @text, time_string]
  end

  # Метод to_db_hash у Задачи добавляет два ключа в хэш
  def to_db_hash
    # Вызываем родительский метод to_db_hash ключевым словом super. К хэшу,
    # который он вернул добавляем специфичные для этого класса поля методом
    # Hash#merge
    super.merge('text' => @text, 'due_date' => remaining)
  end

  # Метод load_data у Задачи считывает дополнительно due_date задачи
  def load_data(data_hash)
    # Сперва дергаем родительский метод load_data для общих полей. Обратите
    # внимание, что вызов без параметров тут эквивалентен super(data_hash), так
    # как те же параметры будут переданы методу super автоматически.
    super

    # Теперь достаем из хэша специфичное только для задачи значение due_date
    @due_date = Date.parse(data_hash['due_date'])
  end
end
