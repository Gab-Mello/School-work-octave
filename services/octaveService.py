import subprocess

def generateGraphs(data):

    octave_terminal_path = "C:/Program Files/GNU Octave/Octave-9.2.0/mingw64/bin/octave.exe"

    command = [octave_terminal_path, "--eval", f"addpath('./octave_script'); modelo_fotovoltaico({data.I_SC}, {data.V_dc});"]

    try:
        result = subprocess.run(command, capture_output=True, text=True, check=True)
        print("Octave output:")
        print(result.stdout)  

    except subprocess.CalledProcessError as e:
        print("Octave execution failed:")
        print(e.stderr) 

