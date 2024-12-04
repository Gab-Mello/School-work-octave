function modelo_fotovoltaico(I_SC, V_dc, R_sh, T, J_0)
    % Criar a pasta 'static' se necessário
    if ~exist('static', 'dir')
        mkdir('static');
    end
    
    % Constantes
    q = 1.60217662 * 10^(-19);  % Carga elementar (C)
    k = 1.38064852 * 10^(-23);  % Constante de Boltzmann (J/K)
    n = 1.4;                    % Fator de idealidade
    T_ref = 298.15;             % Temperatura de referência (K)
    I_00 = 1.2799e-8;           % Corrente de saturação inicial (A)
    G_ref = 1000;               % Irradiância de referência (W/m²)

    % Tensão (V)
    V = linspace(0, V_dc, 100); % Varia de 0 a V_dc

    % Curvas para irradiância variável
    G_vals = [200, 500, 800, 1000]; % Irradiâncias em W/m²

    % Gráfico I-V para diferentes irradiâncias
    figure('visible', 'off'); % Cria uma figura invisível
    hold on;
    legend_entries = {};

    for G = G_vals
        % Cálculo da corrente de fotocorrente ajustada com coeficiente de temperatura
        I_ph = (I_SC + J_0 * (T - T_ref)) * (G / G_ref);

        % Cálculo da corrente de saturação dependente da temperatura
        I_0 = I_00 * (T / T_ref)^3 * exp(-q * 1.12 / (n * k) * (1 / T - 1 / T_ref));

        % Corrente (I)
        I = I_ph - I_0 * (exp((q * V) / (n * k * T)) - 1) - V / R_sh;
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
        % Cálculo da corrente de fotocorrente ajustada com coeficiente de temperatura
        I_ph = (I_SC + J_0 * (T - T_ref)) * (G / G_ref);

        % Cálculo da corrente de saturação dependente da temperatura
        I_0 = I_00 * (T / T_ref)^3 * exp(-q * 1.12 / (n * k) * (1 / T - 1 / T_ref));

        % Corrente (I) e Potência (P)
        I = I_ph - I_0 * (exp((q * V) / (n * k * T)) - 1) - V / R_sh;
        P = V .* I; % Potência é o produto da tensão pela corrente

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

    % Curvas para diferentes temperaturas
    temperatures = [273.15 + 25, 273.15 + 35, 273.15 + 45, 273.15 + 55]; % Temperaturas em K

    % Gráfico I-V para diferentes temperaturas
    figure('visible', 'off');
    hold on;
    legend_entries = {};

    for T = temperatures
        I_ph = (I_SC + J_0 * (T - T_ref)) * (G_ref / G_ref);
        I_0 = I_00 * (T / T_ref)^3 * exp(-q * 1.12 / (n * k) * (1 / T - 1 / T_ref));
        I = I_ph - I_0 * (exp((q * V) / (n * k * T)) - 1) - V / R_sh;
        I(I < 0) = NaN;

        plot(V, I);
        legend_entries = [legend_entries, {['T = ' num2str(T - 273.15) ' °C']}];
    end

    xlabel('Tensão (V)');
    ylabel('Corrente (I)');
    title('Curva I-V para Diferentes Temperaturas');
    grid on;
    legend(legend_entries);
    print('static/curva_IV_temperatura.png', '-dpng', '-r300');

    % Gráfico P-V para diferentes temperaturas
    figure('visible', 'off');
    hold on;
    legend_entries = {};

    for T = temperatures
        I_ph = (I_SC + J_0 * (T - T_ref)) * (G_ref / G_ref);
        I_0 = I_00 * (T / T_ref)^3 * exp(-q * 1.12 / (n * k) * (1 / T - 1 / T_ref));
        I = I_ph - I_0 * (exp((q * V) / (n * k * T)) - 1) - V / R_sh;
        P = V .* I;
        I(I < 0) = NaN;
        P(P < 0) = NaN;

        plot(V, P);
        legend_entries = [legend_entries, {['T = ' num2str(T - 273.15) ' °C']}];
    end

    xlabel('Tensão (V)');
    ylabel('Potência (P)');
    title('Curva P-V para Diferentes Temperaturas');
    grid on;
    legend(legend_entries);
    print('static/curva_PV_temperatura.png', '-dpng', '-r300');
end
