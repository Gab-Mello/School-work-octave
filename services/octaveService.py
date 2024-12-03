import subprocess

def generateGraphs(data):

    octave_terminal_path = "/usr/bin/octave"

    command = [octave_terminal_path, "--eval", f"addpath('./octave_script'); modelo_fotovoltaico({data.I_SC});"]

    try:
        result = subprocess.run(command, capture_output=True, text=True, check=True)
        print("Octave output:")
        print(result.stdout)  

    except subprocess.CalledProcessError as e:
        print("Octave execution failed:")
        print(e.stderr) 

