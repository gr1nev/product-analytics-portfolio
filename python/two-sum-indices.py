# Задача: дан список nums и число target. Вернуть индексы двух элементов,
# сумма которых равна target.
# Пример: nums = [2, 7, 11, 15], target = 9 -> [0, 1]

def func(nums, target):
    x = {}
    for index, i in enumerate(nums):
        n = target - i
        if n in x:
            return [x[n], index]
        x[i] = index

print(func([3, 3], 6))
