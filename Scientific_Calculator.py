
import sys

# Constants
PI = 3.141592653589793
E = 2.718281828459045

# Basic Arithmetic
def add(a, b):
    return a + b

def subtract(a, b):
    return a - b

def multiply(a, b):
    return a * b

def divide(a, b):
    if b == 0:
        return "Error: Division by zero"
    return a / b

def modulus(a, b):
    if b == 0:
        return "Error: Modulus by zero"
    return a % b

# Power and Square Root
def power(a, b):
    result = 1
    for _ in range(abs(b)):
        result *= a
    return result if b >= 0 else 1 / result

def square_root(n):
    if n < 0:
        return "Error: Negative number"
    x = n
    for _ in range(20):
        x = 0.5 * (x + n / x)
    return x

# Factorial
def factorial(n):
    if n < 0:
        return "Error: Negative factorial"
    f = 1
    for i in range(1, n+1):
        f *= i
    return f

# Exponential (e^x)
def exponential(x):
    result = 1.0
    term = 1.0
    for i in range(1, 20):
        term *= x / i
        result += term
    return result

# Logarithm base e and base 10 using series (natural log approximation)
def natural_log(x):
    if x <= 0:
        return "Error: ln of non-positive number"
    n = 1000.0
    return n * ((x ** (1/n)) - 1)

def log_base_10(x):
    ln10 = natural_log(10)
    ln_x = natural_log(x)
    if isinstance(ln_x, str):
        return ln_x
    return ln_x / ln10

# Degree ↔ Radian conversion
def deg_to_rad(deg):
    return deg * PI / 180

def rad_to_deg(rad):
    return rad * 180 / PI

# Trigonometric Functions
def sin(x):
    x = x % (2 * PI)
    result = 0
    for i in range(10):
        term = power(-1, i) * power(x, 2*i + 1) / factorial(2*i + 1)
        result += term
    return result

def cos(x):
    x = x % (2 * PI)
    result = 0
    for i in range(10):
        term = power(-1, i) * power(x, 2*i) / factorial(2*i)
        result += term
    return result

def tan(x):
    cos_val = cos(x)
    if cos_val == 0:
        return "Error: tan undefined"
    return sin(x) / cos_val

# Number System Conversions
def to_binary(n):
    return bin(n)[2:]

def to_octal(n):
    return oct(n)[2:]

def to_hex(n):
    return hex(n)[2:]

def from_binary(s):
    return int(s, 2)

def from_octal(s):
    return int(s, 8)

def from_hex(s):
    return int(s, 16)

# ---------------- MAIN TEST AREA ---------------- #

# Example Usage:
print("----- BASIC ARITHMETIC -----")
print("Add:", add(5, 3))
print("Subtract:", subtract(10, 4))
print("Multiply:", multiply(6, 7))
print("Divide:", divide(20, 5))
print("Modulus:", modulus(23, 5))

print("\n----- ADVANCED FUNCTIONS -----")
print("Power:", power(2, 5))
print("Square Root of 25:", square_root(25))
print("Factorial of 5:", factorial(5))
print("Exponential (e^2):", exponential(2))
print("Natural Log (ln 5):", natural_log(5))
print("Log Base 10 (log 100):", log_base_10(100))

print("\n----- TRIGONOMETRY (in degrees) -----")
angle = 30
radian = deg_to_rad(angle)
print(f"sin({angle}) =", sin(radian))
print(f"cos({angle}) =", cos(radian))
print(f"tan({angle}) =", tan(radian))

print("\n----- ANGLE CONVERSIONS -----")
print("Degrees to Radians (180°):", deg_to_rad(180))
print("Radians to Degrees (π):", rad_to_deg(PI))

print("\n----- NUMBER SYSTEM CONVERSIONS -----")
print("Decimal to Binary (10):", to_binary(10))
print("Decimal to Octal (10):", to_octal(10))
print("Decimal to Hex (10):", to_hex(10))
print("Binary to Decimal (1010):", from_binary("1010"))
print("Octal to Decimal (12):", from_octal("12"))
print("Hex to Decimal (A):", from_hex("A"))

# ---------------- USER INTERACTION ---------------- #

def calculator_menu():
    print("\n--- SCIENTIFIC CALCULATOR ---")
    print("Choose a function:")
    print("1. Add\n2. Subtract\n3. Multiply\n4. Divide\n5. Modulus")
    print("6. Power\n7. Square Root\n8. Factorial\n9. Exponential")
    print("10. Natural Log\n11. Log Base 10")
    print("12. sin(x)\n13. cos(x)\n14. tan(x)")
    print("15. Degree to Radian\n16. Radian to Degree")
    print("17. Decimal to Binary/Octal/Hex")
    print("18. Binary/Octal/Hex to Decimal")
    print("0. Exit")

while True:
    calculator_menu()
    try:
        choice = int(input("Enter choice: "))
        if choice == 0:
            print("Exiting...")
            break
        elif choice == 1:
            a, b = float(input("Enter 2 numbers: ")), float(input())
            print("Result:", add(a, b))
        elif choice == 2:
            a, b = float(input("Enter 2 numbers: ")), float(input())
            print("Result:", subtract(a, b))
        elif choice == 3:
            a, b = float(input("Enter 2 numbers: ")), float(input())
            print("Result:", multiply(a, b))
        elif choice == 4:
            a, b = float(input("Enter numerator and denominator: ")), float(input())
            print("Result:", divide(a, b))
        elif choice == 5:
            a, b = int(input("Enter 2 integers: ")), int(input())
            print("Result:", modulus(a, b))
        elif choice == 6:
            a, b = float(input("Enter base and exponent: ")), int(input())
            print("Result:", power(a, b))
        elif choice == 7:
            n = float(input("Enter number: "))
            print("Result:", square_root(n))
        elif choice == 8:
            n = int(input("Enter number: "))
            print("Result:", factorial(n))
        elif choice == 9:
            x = float(input("Enter exponent: "))
            print("Result:", exponential(x))
        elif choice == 10:
            x = float(input("Enter number: "))
            print("Result:", natural_log(x))
        elif choice == 11:
            x = float(input("Enter number: "))
            print("Result:", log_base_10(x))
        elif choice == 12:
            deg = float(input("Enter angle in degrees: "))
            print("sin:", sin(deg_to_rad(deg)))
        elif choice == 13:
            deg = float(input("Enter angle in degrees: "))
            print("cos:", cos(deg_to_rad(deg)))
        elif choice == 14:
            deg = float(input("Enter angle in degrees: "))
            print("tan:", tan(deg_to_rad(deg)))
        elif choice == 15:
            deg = float(input("Enter degrees: "))
            print("Radians:", deg_to_rad(deg))
        elif choice == 16:
            rad = float(input("Enter radians: "))
            print("Degrees:", rad_to_deg(rad))
        elif choice == 17:
            n = int(input("Enter decimal number: "))
            print("Binary:", to_binary(n))
            print("Octal:", to_octal(n))
            print("Hex:", to_hex(n))
        elif choice == 18:
            b = input("Enter number: ")
            base = input("Base (bin/oct/hex): ").lower()
            if base == "bin":
                print("Decimal:", from_binary(b))
            elif base == "oct":
                print("Decimal:", from_octal(b))
            elif base == "hex":
                print("Decimal:", from_hex(b))
            else:
                print("Invalid base")
        else:
            print("Invalid choice.")
    except Exception as e:
        print("Error:", e)





