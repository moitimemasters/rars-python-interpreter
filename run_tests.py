import typing as tp

import os
import sys
import subprocess
import shutil


class DiffException(Exception): ...


def get_and_store_env(key: str) -> str:
    if item := os.environ.get(key):
        return item
    return os.environ.setdefault(
        key,
        input(f"Enter env value for {key}:"),
    )


def run_rars_program(jar_path: str, py_file: str) -> str:
    command = f"java -jar {jar_path} nc sm p rv64 stage2/main.s pa {py_file}"
    print("runnning command:", command)
    with subprocess.Popen(
        command.split(),
        universal_newlines=True,
        stdout=subprocess.PIPE,
    ) as sp:
        sp.wait()
        if sp.returncode != 0:
            return "Exit code: {sp.returncode}"

        return sp.stdout.read()


def canonize(output: str, py_file: str):
    test_name = py_file[:-3]
    dir = "tests/canondata/"
    file = f"{dir}/{test_name}.out"
    if os.path.exists(file):
        with open(file) as f:
            contents = f.read()
        if contents != output:
            raise DiffException(f"{test_name} output differs with canonical data: \n{contents}")
    if not os.path.exists(dir):
        os.mkdir(dir)

    with open(file, "w") as f:
        f.write(output)


def clear_canondata():
    if os.path.exists("tests/canondata"):
        shutil.rmtree("tests/canondata")


def main():
    do_clear_canondata = len(sys.argv) > 1 and sys.argv[1] == "-Z"
    if do_clear_canondata:
        clear_canondata()
    rars_jar_file = get_and_store_env("RARS_JAR_FILE")
    for py_file in os.listdir("tests"):
        if not py_file.endswith(".py"):
            continue

        output = run_rars_program(rars_jar_file, f"tests/{py_file}")
        try:
            canonize(output, py_file)
        except DiffException as e:
            print(f"Test {py_file} failed:")
            print(e)
            raise
        print(f"Test {py_file} passed")


if __name__ == "__main__":
    main()
