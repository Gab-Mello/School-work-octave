function modelo_fotovoltaico()
    % Criar a pasta 'static' se necessário
    if ~exist('static', 'dir')
        mkdir('static');
    end

    % Constantes
    q = 1.60217662 * 10^(-19);  % Carga elementar (C)
    k = 1.38064852 * 10^(-23);  % Constante de Boltzmann (J/K)
    n = 1.4;                     % Fator de idealidade
    T_0 = 298.15;                % Temperatura de referência (K)
    I_SC = 5;                    % Corrente de curto-circuito (A)
    I_00 = 1.2799e-8;            % Corrente de saturação inicial (A)
    R_sh = 100;                  % Resistência de shunt (Ω)
    V_dc = 0.72;                 % Tensão de circuito aberto (V)

    % Tensão (V)
    V = linspace(0, V_dc, 100);  % Varia de 0 a 0.72V

    % Curvas para irradiância variável
    G_vals = [200, 500, 800, 1000]; % Irradiâncias em W/m²

    % Gráfico I-V para diferentes irradiâncias
    figure('visible', 'off'); % Cria uma figura invisível
    hold on;
    legend_entries = {};

    for G = G_vals
        I_ph = (G / 1000) * I_SC;  % Corrente fotovoltaica gerada
        I_0 = I_00 * (T_0 / 298.15)^3 * exp(-q * 1.12 / (n * k) * (1 / T_0 - 1 / 298.15));

        % Corrente (I)
        I = I_ph - I_0 * (exp((q * V) / (n * k * T_0)) - 1) - V / R_sh;
        I(I < 0) = NaN; % Corrente negativa não é fisicamente possível

        plot(V, I);
        legend_entries = [legend_entries, {['G = ' num2str(G) ' W/m²']}];
    end

    xlabel('Tensão (V)');
    ylabel('Corrente (I)');
    title('Curva I-V para Diferentes Irradiâncias');
    grid on;
    legend(legend_entries);
    print('static/curva_IV_irradiancia.png', '-dpng', '-r300'); % Salvar gráfico

    % Gráfico P-V para diferentes irradiâncias
    figure('visible', 'off'); % Cria uma figura invisível
    hold on;
    legend_entries = {};

    for G = G_vals
        I_ph = (G / 1000) * I_SC;  % Corrente fotovoltaica gerada
        I_0 = I_00 * (T_0 / 298.15)^3 * exp(-q * 1.12 / (n * k) * (1 / T_0 - 1 / 298.15));

        % Corrente (I) e Potência (P)
        I = I_ph - I_0 * (exp((q * V) / (n * k * T_0)) - 1) - V / R_sh;
        P = V .* I;

        I(I < 0) = NaN; % Corrente negativa não é fisicamente possível
        P(P < 0) = NaN; % Potência negativa não é fisicamente possível

        plot(V, P);
        legend_entries = [legend_entries, {['G = ' num2str(G) ' W/m²']}];
    end

    xlabel('Tensão (V)');
    ylabel('Potência (P)');
    title('Curva P-V para Diferentes Irradiâncias');
    grid on;
    legend(legend_entries);
    print('static/curva_PV_irradiancia.png', '-dpng', '-r300'); % Salvar gráfico

    % Curvas para temperatura variável
    temperatures = [298.15, 308.15, 318.15, 328.15]; % Temperaturas de 25°C a 55°C

    % Gráfico I-V para diferentes temperaturas
    figure('visible', 'off'); % Cria uma figura invisível
    hold on;
    legend_entries = {};

    for T = temperatures
        I_ph = (1000 / 1000) * I_SC;  % Corrente fotovoltaica gerada para G = 1000 W/m²
        I_0 = I_00 * (T / 298.15)^3 * exp(-q * 1.12 / (n * k) * (1 / T - 1 / 298.15));

        % Corrente (I)
        I = I_ph - I_0 * (exp((q * V) / (n * k * T)) - 1) - V / R_sh;
        I(I < 0) = NaN; % Corrente negativa não é fisicamente possível

        plot(V, I);
        legend_entries = [legend_entries, {['T = ' num2str(T - 273.15) ' °C']}];
    end

    xlabel('Tensão (V)');
    ylabel('Corrente (I)');
    title('Curva I-V para Diferentes Temperaturas');
    grid on;
    legend(legend_entries);
    print('static/curva_IV_temperatura.png', '-dpng', '-r300'); % Salvar gráfico

    % Gráfico P-V para diferentes temperaturas
    figure('visible', 'off'); % Cria uma figura invisível
    hold on;
    legend_entries = {};

    for T = temperatures
        I_ph = (1000 / 1000) * I_SC;  % Corrente fotovoltaica gerada para G = 1000 W/m²
        I_0 = I_00 * (T / 298.15)^3 * exp(-q * 1.12 / (n * k) * (1 / T - 1 / 298.15));

        % Corrente (I) e Potência (P)
        I = I_ph - I_0 * (exp((q * V) / (n * k * T)) - 1) - V / R_sh;
        P = V .* I;

        I(I < 0) = NaN; % Corrente negativa não é fisicamente possível
        P(P < 0) = NaN; % Potência negativa não é fisicamente possível

        plot(V, P);
        legend_entries = [legend_entries, {['T = ' num2str(T - 273.15) ' °C']}];
    end

    xlabel('Tensão (V)');
    ylabel('Potência (P)');
    title('Curva P-V para Diferentes Temperaturas');
    grid on;
    legend(legend_entries);
    print('static/curva_PV_temperatura.png', '-dpng', '-r300'); % Salvar gráfico
end
