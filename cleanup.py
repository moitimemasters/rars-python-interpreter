import os
import random
import string


def generate_random_label() -> str:
    return "".join(random.choices(string.ascii_uppercase, k=6))


def filter_directives(lines, unrecognized_directives):
    processed_lines = []
    for line in lines:
        if any(directive in line for directive in unrecognized_directives):
            continue

        if ".align" in line:
            if "text" in processed_lines[-1]:
                alignment = int(line.split()[-1])
                if alignment < 2:
                    line = ".align 2\n"
            else:
                continue

        processed_lines.append(line)
    return processed_lines


def invert_branches(lines):
    branches = {
        "beq": "bne",
        "bne": "beq",
        "blt": "bge",
        "bge": "blt",
        "bltu": "bgeu",
        "bgeu": "bltu",
        "bleu": "bgtu",
        "bgtu": "bleu",
        "ble": "bgt",
        "bgt": "ble",
    }

    output_lines = []
    for line in lines:
        # Чтобы обработать табуляцию и запятые, мы сначала заменяем запятые на пробелы, а затем разбиваем строку на токены.
        tokens = line.replace("\t", " ").replace(",", " ").split()
        if len(tokens) > 0 and tokens[0] in branches:
            tokens[0] = branches[tokens[0]]
            label = tokens[3]
            tokens[3] = generate_random_label()
            output_lines.append("\t" + " ".join(tokens) + "\n")
            output_lines.append("\tla t1, " + label + "\n")
            output_lines.append("\tjalr t1\n")
            output_lines.append(tokens[3] + ":\n")
        else:
            output_lines.append(line)
    return output_lines


def write_file(filepath, lines):
    with open(filepath, "w") as file:
        file.writelines(lines)


def process_file(filepath, unrecognized_directives):
    with open(filepath, "r") as file:
        lines = file.readlines()

    processed_lines = filter_directives(lines, unrecognized_directives)
    # processed_lines = invert_branches(processed_lines)

    return processed_lines


def main():
    input_dir = "stage1/"
    output_dir = "stage2/"

    os.makedirs(output_dir, exist_ok=True)

    unrecognized_directives = [".file", ".option", ".attribute", ".type", ".size", ".ident"]

    for filename in os.listdir(input_dir):
        filepath = os.path.join(input_dir, filename)
        processed_lines = process_file(filepath, unrecognized_directives)

        output_filepath = os.path.join(output_dir, filename)
        write_file(output_filepath, processed_lines)


if __name__ == "__main__":
    main()
