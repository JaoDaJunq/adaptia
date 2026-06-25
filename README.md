# Adaptia RPG

Estrutura pronta para GitHub Pages com login via Supabase Auth.

## Pastas

- `index.html`: Hub inicial com login/cadastro e Meus Herois
- `criador/index.html`: Criador de personagem vinculado ao usuario logado
- `tela/index.html`: Tela do Mestre
- `controle/index.html`: Controle do jogador com escolha de personagem da conta
- `regras/index.html`: Livro de Regras
- `arquivo-antigo/criador-v1.html`: Backup da versao antiga do criador

## Publicacao

Suba todos os arquivos e pastas na raiz do repositorio GitHub e ative o GitHub Pages em:

Settings > Pages > Deploy from a branch > main > /root

## Supabase

Antes de usar a versao com login:

1. Authentication > Sign In / Providers
2. Email provider habilitado
3. Confirm email desligado
4. Rodar `supabase-patch.sql` no SQL Editor

O login visual usa usuario + senha, mas internamente o app converte para um e-mail do tipo `usuario@adaptia.local`.
