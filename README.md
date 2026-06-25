# Adaptia RPG

Estrutura pronta para GitHub Pages.

## Pastas

- `index.html`: Hub inicial
- `criador/index.html`: Criador de personagem com Supabase e emblema
- `tela/index.html`: Tela do Mestre
- `controle/index.html`: Controle do jogador
- `regras/index.html`: Livro de Regras v1
- `arquivo-antigo/criador-v1.html`: Backup da versão antiga do criador
- `supabase-patch.sql`: patch recomendado para garantir coluna `aparencia` e Realtime

## Publicação

Suba todos os arquivos e pastas na raiz do repositório GitHub e ative o GitHub Pages em:

Settings > Pages > Deploy from a branch > main > /root

## Observação

Antes de testar o fluxo completo, rode o conteúdo de `supabase-patch.sql` no SQL Editor do Supabase caso ainda não tenha aplicado a coluna `aparencia` e a publicação Realtime.
