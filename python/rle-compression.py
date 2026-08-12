# Задача: реализовать RLE-сжатие строки.
# "AABBBCC" -> "A2B3C2", символ с 1 повторением записывается как "A1"

def func(word):
    cnt = 1
    res = ''
    pred = word[0]
    for i in range(1, len(word)):
        if pred == word[i]:
            cnt += 1
        else:
            res += pred + str(cnt)
            pred = word[i]
            cnt = 1
    res += pred + str(cnt)
    return res

print(func('AAWWDDDDSIOPPPROKKKKKKKKK'))
