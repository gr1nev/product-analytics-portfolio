# Задача: посчитать число уникальных сессий по пользователю.
# Сессия обрывается, если разрыв между событиями больше 30 минут.
# Pandas-аналог SQL-задачи session-detection.sql — та же логика на другом стеке.

import pandas as pd

df = pd.DataFrame({
    'user_id': ['u1','u1','u1','u1','u2','u2','u2'],
    'dttm': [
        '2022-01-01 10:00:00', '2022-01-01 10:15:00',
        '2022-01-01 10:50:00', '2022-01-01 11:00:00',
        '2022-01-01 09:00:00', '2022-01-01 09:10:00',
        '2022-01-01 10:00:00'
    ]
})
df['dttm'] = pd.to_datetime(df['dttm'])

df = df.sort_values(['user_id', 'dttm'])
df['time_diff'] = df.groupby('user_id')['dttm'].diff().fillna(pd.Timedelta(minutes=31))
df['is_new_session'] = df['time_diff'] > pd.Timedelta(minutes=30)
df['session_id'] = df.groupby('user_id')['is_new_session'].cumsum()

result = df.groupby('user_id')['session_id'].max()
print(result)
