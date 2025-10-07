# Caesar Cipher CLI

A simple Haskell command-line tool for encrypting, decrypting, and analyzing text using Caesar cipher, ROT135, and frequency-based decryption.

---

## Features

* **Caesar Cipher**: Encrypt any text with a custom shift.
* **ROT135 Cipher**: Rotate letters and digits by 13 or 5 respectively.
* **Automatic Caesar Decryption**: Attempt to decrypt Caesar-encrypted text using letter frequency analysis.
* **Flexible Input**: Supports both command-line arguments and piped input.

---

## Usage

### 1. Caesar Cipher (Custom Shift)

Encrypt text with a custom numeric shift:

```bash
./caesar <shift> "<text>"
```

**Example:**

```bash
./caesar 3 "HELLO WORLD"
# Output: KHOOR ZRUOG
```

---

### 2. ROT135 Cipher (Default)

Encrypt text with ROT135 (letters rotated by 13, digits by 5):

```bash
./caesar "<text>"
```

**Example:**

```bash
./caesar "HELLO123"
# Output: URYYB678
```

---

### 3. Automatic Caesar Decryption

Attempt to decrypt text encrypted with a Caesar cipher:

```bash
./caesar decrypt "<ciphertext>"
```

**Example:**

```bash
./caesar decrypt "KHOOR ZRUOG"
# Output: HELLO WORLD
```


---

## Installation

1. Clone the repository:

```bash
git clone <repo-url>
cd caesar
```

2. Build the project with Cabal:

```bash
cabal build
```

3. Run the program:

```bash
cabal run -- 3 "HELLO WORLD"
```

Or use the compiled executable directly:

```bash
$(cabal list-bin caesar) decrypt "KHOOR ZRUOG"
```

---

## Notes

* The program works with both **command-line arguments** and **stdin piping**.
* ROT135 rotates letters by 13 and digits by 5, leaving other characters unchanged.
* The automatic decryption assumes English text and uses frequency analysis of letters, so very short or unusual texts may not decrypt accurately.

---

## License
[LICENSE]
