select
	cliente.primeiro_nome, 
    cliente.ultimo_nome,
    filme.titulo,
    categoria.nome,
    ator.primeiro_nome,
    ator.ultimo_nome,
     /*aqui selecionamos a tabela cliente ,filme e ator com as chaves primarias para usar nos joins */
	case
        when idioma.nome = 'English' THEN 'Inglês'
        when idioma.nome = 'Italian' THEN 'Italiano'
        when idioma.nome = 'Japanise' THEN 'Japones'
        when idioma.nome = 'Mandarin' THEN 'Mandarim'
		when idioma.nome = 'French' THEN 'Francês'
		when idioma.nome = 'German' THEN 'Alemão'
        ELSE idioma.nome
         /* as condicionais para separar os idiomas dos filmes  */
	end as idioma_filme,
    pagamento.valor
    as 
    valor, 
    funcionario.primeiro_nome, 
    funcionario.ultimo_nome
from
	/*aqui usamos o inner para juntar as tabelas citadas a baixo */
	cliente
	INNER JOIN aluguel ON 
		cliente.cliente_id = aluguel.cliente_id
    INNER JOIN pagamento ON 
		aluguel.aluguel_id = pagamento.aluguel_id
    INNER JOIN funcionario ON 
		aluguel.funcionario_id = funcionario.funcionario_id
    INNER JOIN inventario ON 
		aluguel.inventario_id = inventario.inventario_id
    INNER JOIN filme ON 
		inventario.filme_id = filme.filme_id
    INNER JOIN filme_categoria ON 
		filme.filme_id = filme_categoria.filme_id
    INNER JOIN categoria ON 
		filme_categoria.categoria_id = categoria.categoria_id
    INNER JOIN filme_ator ON 
		filme.filme_id = filme_ator.filme_id
    INNER JOIN ator ON 
		filme_ator.ator_id = ator.ator_id
    INNER JOIN idioma ON 
		filme.idioma_id = idioma.idioma_id
where
/* aqui colocamos para aparecer apenas os filmes com duração maior que 90min e com o idioma somente portugues */
	filme.duracao_do_filme > 90

group by
	/* afrupamento de tabelas */
    cliente.primeiro_nome, cliente.ultimo_nome, 
    filme.titulo, categoria.nome, 
    ator.primeiro_nome, ator.ultimo_nome,
    idioma.nome, pagamento.valor, 
    funcionario.primeiro_nome, funcionario.ultimo_nome
order by
	/*ordenamento de tabelas */
	cliente.primeiro_nome, cliente.ultimo_nome, filme.titulo
    