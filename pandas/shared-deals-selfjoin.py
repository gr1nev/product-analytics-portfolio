# Задача: найти всех клиентов, у которых есть общие сделки (deal_id),
# вернуть список пар клиентов с количеством общих сделок.
# Применение: поиск связанных аккаунтов по совпадающим транзакциям —
# частый признак мошеннической схемы (fraud rings).

import pandas as pd

df = pd.DataFrame({
    "user_id": [1, 1, 2, 2, 3, 3],
    "deal_id": [101, 102, 102, 103, 101, 104]
})

res = df.merge(df, on='deal_id')
f_res = res[res['user_id_x'] < res['user_id_y']]

result = (
    f_res.groupby(['user_id_x', 'user_id_y'])['deal_id']
    .count()
    .reset_index(name='shared_deals')
    .rename(columns={'user_id_x': 'user_1', 'user_id_y': 'user_2'})
)
print(result)
