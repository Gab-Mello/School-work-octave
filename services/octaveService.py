import subprocess

def generateGraphs():# Caminho para o Octave completo (não CLI)
    octave_terminal_path = "C:/Program Files/GNU Octave/Octave-9.2.0/mingw64/bin/octave.exe"

    # Caminho para o script Octave
    octave_script_path = "./octave_script/otavio.m"

    # Comando para executar o script no terminal completo
    command = [octave_terminal_path, "--eval", f"addpath('./octave_script/'); otavio;"]

    try:
        # Executar o script Octave
        result = subprocess.run(command, capture_output=True, text=True, check=True)
        print("Saída do Octave:")
        print(result.stdout)  # Saída do script
    except subprocess.CalledProcessError as e:
        print("Erro ao executar o script Octave:")
        print(e.stderr)  # Exibe mensagens de erro do Octave

