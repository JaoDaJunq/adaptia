# Adaptia RPG

Versão com login por usuário/senha e inventário em leitura na ficha do Hub.

## Estrutura

- `index.html`: Hub inicial com login, Meus Heróis, importação de ficha antiga e ficha completa com inventário
- `criador/index.html`: Criador de personagem com login e item inicial no inventário sem equipar automaticamente
- `tela/index.html`: Tela do Mestre
- `controle/index.html`: Controle do jogador com login
- `regras/index.html`: Livro de regras
- `arquivo-antigo/criador-v1.html`: Backup da versão antiga do criador

## Publicação

Suba o conteúdo extraído deste ZIP na raiz do repositório GitHub Pages.

Não suba a pasta-mãe nem o ZIP fechado.

## Inventário

Este passo adiciona no Hub o botão `Abrir ficha`, exibindo:

- dados básicos do personagem
- nível, XP, PV e mana
- atributos e modificadores
- inventário vindo de `personagem_itens`
- dados do item vindo de `itens_catalogo`
- itens equipados, se houver
- habilidades e sinergia

