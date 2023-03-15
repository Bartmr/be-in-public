- Experimentar alterar dados de outro utilizador, ao fazer requests directos aos endpoints com o ID do recurso não-autorizado que quero alterar, mas com sessão iniciada com uma conta dummy (para o atacante não ser associado à operação não-autorizada)
  - Porquê? Muitos serviços verificam apenas se o token de sessão é válido, e não se o utilizador tem permissão para ver/alterar os dados.
- SQL injection: inserir um comando SQL qualquer, mesmo que não seja algo válido. Se o request retornar 500, quer dizer que o servidor correu esse mesmo código inválido, e que o site está a correr inputs do utilizador dentro dos comandos SQL. O site está vulnerável a injecções de SQL
 