import random
import string
from datetime import datetime


def generate_password(length=16, use_special=True):
    chars = string.ascii_letters + string.digits
    if use_special:
        chars += "!@#$%^&*()-_=+"
    return ''.join(random.choice(chars) for _ in range(length))


def check_strength(password):
    score = 0
    if len(password) >= 12:
        score += 1
    if len(password) >= 20:
        score += 1
    if any(c.islower() for c in password):
        score += 1
    if any(c.isupper() for c in password):
        score += 1
    if any(c.isdigit() for c in password):
        score += 1
    if any(c in "!@#$%^&*()-_=+" for c in password):
        score += 1

    if score <= 3:
        return "🔴 слабый"
    elif score <= 5:
        return "🟡 средний"
    else:
        return "🟢 сильный"


def save_to_file(passwords):
    filename = "passwords.txt"
    with open(filename, "a", encoding="utf-8") as f:
        f.write(f"\n--- {datetime.now():%Y-%m-%d %H:%M} ---\n")
        for p in passwords:
            f.write(p + "\n")
    print(f"💾 Сохранено в {filename}")


def ask_int(prompt, default):
    try:
        value = input(prompt)
        return int(value) if value.strip() else default
    except ValueError:
        return default


def ask_yes_no(prompt, default=True):
    answer = input(prompt).strip().lower()
    if not answer:
        return default
    return answer in ("y", "yes", "д", "да")


def main():
    print("🎲 Генератор паролей v2\n")

    length = ask_int("Длина пароля (Enter = 16): ", 16)
    count = ask_int("Сколько паролей сгенерировать? (Enter = 1): ", 1)
    use_special = ask_yes_no("Добавлять спецсимволы? (Y/n): ", True)

    print()
    passwords = []
    for i in range(count):
        pwd = generate_password(length, use_special)
        passwords.append(pwd)
        print(f"{i+1}. {pwd}   [{check_strength(pwd)}]")

    if ask_yes_no("\nСохранить в файл? (y/N): ", False):
        save_to_file(passwords)


if __name__ == "__main__":
    main()
