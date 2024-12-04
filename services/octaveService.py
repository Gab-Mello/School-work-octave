import subprocess

def generateGraphs(data):

    octave_terminal_path = "/usr/bin/octave"
    
    kelvin_T = data.T + 273.15

    command = [octave_terminal_path, "--eval", f"addpath('./octave_script'); modelo_fotovoltaico({data.I_SC}, {data.V_dc}, {data.R_sh}, {kelvin_T}, {data.J_0});"]

    try:
        result = subprocess.run(command, capture_output=True, text=True, check=True)
        print("Octave output:")
        print(result.stdout)  

    except subprocess.CalledProcessError as e:
        print("Octave execution failed:")
        print(e.stderr) 

