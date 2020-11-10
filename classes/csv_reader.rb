# frozen_string_literal: true

class CsvReader
  require 'csv'

  def initialize(csv_file_name)
    # Создаем переменную с путем до CSV файла
    @csv_file_dir = "csv_db/#{csv_file_name}"
  end

  # Возвращает хэш со списком цен
  def read_vm_prices
    csv = read_csv
    csv_result = {}

    csv.each do |arr|
      csv_result[arr[0].to_sym] = arr[1]
    end

    csv_result
  end

  private

  # Меняет на числа те строки, который выражают собой числа
  def reveal_integers(arr)
    arr.map { |val| val.match?(/\A\d+\z/) ? val.to_i : val }
  end

  # CSV.open возвращает 2-мерный массив
  def read_csv
    csv = CSV.open(@csv_file_dir)
    csv.map { |arr| reveal_integers(arr) }
  end
end
