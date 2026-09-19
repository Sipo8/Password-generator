import random
import string


def generate_password(length=16):
    chars = string.ascii_letters + string.digits + "!@#$%^&*()-_=+"
    return ''.join(random.choice(chars) for _ in range(length))


def main():
    print("🎲 Генератор паролей")
    try:
        length = int(input("Длина пароля (Enter = 16): ") or "16")
    except ValueError:
        length = 16
    print("Ваш пароль:", generate_password(length))


if __name__ == "__main__":
    main()
