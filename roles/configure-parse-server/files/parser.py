import requests
from bs4 import BeautifulSoup
import psycopg2

def parse_website(url):
    # Отправляем GET-запрос к указанному URL
    response = requests.get(url)
    
    # Проверяем, успешно ли получен ответ
    if response.status_code == 200:
        # Создаем объект BeautifulSoup для парсинга HTML-кода
        soup = BeautifulSoup(response.content, 'html.parser')
        
        # Находим необходимые элементы на странице
        titles = soup.find_all('h2', class_='title')
        descriptions = soup.find_all('p', class_='description')
        
        # Инициализируем подключение к базе данных PostgreSQL
        conn = psycopg2.connect(host='192.168.2.66', database='parsing_site', user='vagrant', password='vagrant')
        cursor = conn.cursor()
        
        # Создаем таблицу для хранения результатов парсинга, если она еще не существует
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS parsing_site.parsed_data
            (title VARCHAR(255), description TEXT);
        """)
        
        # Проходимся по найденным элементам и сохраняем их в базу данных
        for title, description in zip(titles, descriptions):
            # Очищаем данные от ненужных символов и экранируем специальные символы
            clean_title = title.text.strip().replace("'", "''")
            clean_description = description.text.strip().replace("'", "''")
            
            # Вставляем данные в таблицу базы данных
            cursor.execute(f"INSERT INTO parsing_site.parsed_data (title, description) VALUES ('{clean_title}', '{clean_description}')")
        
        # Фиксируем изменения в базе данных
        conn.commit()
        
        # Закрываем подключение к базе данных
        cursor.close()
        conn.close()
        
        print("Парсинг завершен и результаты сохранены в базе данных.")
    else:
        print("Ошибка при получении страницы.")
        
# Пример использования функции для парсинга веб-сайта и сохранения результатов в базе данных
parse_website("https://yandex.com")
