def analise_satisfacao(nota):
    if 0 <= nota <= 100:
        if nota >= 90:
            return 'Atendimento de Qualidade'
        elif 89 >= nota >= 70:
            return 'Atendimento Neutro'
        else:
            return 'Atendimento Insatisfatório'
    else:
        return 'Índice de satisfação inválido. Insira um valor entre 0 e 100.'

indice_satisfacao = int(input('Informe o índice de satisfação (0 a 100): '))
print(analise_satisfacao(indice_satisfacao))
