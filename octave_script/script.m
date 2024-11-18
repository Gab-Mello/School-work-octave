% Criar a pasta 'static' se necessário
if ~exist('static', 'dir')
    mkdir('static');
end

% Dados para o primeiro gráfico
x1 = 0:0.1:10;
y1 = sin(x1);

% Criação do primeiro gráfico
figure('visible', 'off'); % Cria uma figura invisível
plot(x1, y1, '-b', 'LineWidth', 2);

% Personalização do primeiro gráfico
title('Gráfico de y = sin(x)');
xlabel('Eixo x');
ylabel('Eixo y');
grid on;
legend('y = sin(x)');

% Salvar o primeiro gráfico
print('static/grafico_seno.png', '-dpng', '-r300'); % Salvar com resolução de 300 DPI

% Dados para o segundo gráfico
x2 = 0:0.1:10;
y2 = cos(x2);

% Criação do segundo gráfico
figure('visible', 'off'); % Cria uma figura invisível
plot(x2, y2, '-r', 'LineWidth', 2); % Linha vermelha

% Personalização do segundo gráfico
title('Gráfico de y = cos(x)');
xlabel('Eixo x');
ylabel('Eixo y');
grid on;
legend('y = cos(x)');

% Salvar o segundo gráfico
print('static/grafico_cosseno.png', '-dpng', '-r300'); % Salvar com resolução de 300 DPI
