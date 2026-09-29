# GravadorTablet

Gravador de tela para tablets Android controlado por atalhos de teclado no Windows. Conecte o tablet por USB, aperte **Ctrl+Alt+G** e a tela é gravada em `.mp4`; **Ctrl+Alt+S** para parar.

Não instala nada no tablet nem no PC: é um script [AutoHotkey v2](https://www.autohotkey.com/) que chama o [scrcpy](https://github.com/Genymobile/scrcpy), incluído na pasta `scrcpy/`.

## Funcionalidades

- Início e parada da gravação por atalho global, sem abrir terminal
- Feedback por bipes e notificação na bandeja do sistema
- Arquivos nomeados com data e hora (`gravacao_AAAA-MM-DD_HH-mm-ss.mp4`)
- Resolução nativa do tablet (`--max-size=0`)
- Portátil: tudo o que é necessário está dentro do repositório

## Requisitos

- Windows 10/11
- Tablet Android com **Depuração USB** ativada
- Cabo USB

Para rodar o `.exe` não é preciso instalar nada. Para rodar ou editar o `.ahk` é necessário o [AutoHotkey v2](https://www.autohotkey.com/).

## Como usar

1. **No tablet**, ative a Depuração USB (só uma vez):
   - Configurações > Sobre o tablet > toque 7 vezes em "Número da versão"
   - Configurações > Opções do desenvolvedor > ative "Depuração USB"
2. Conecte o tablet ao PC e, na pergunta que aparecer no tablet, marque "Sempre permitir deste computador".
3. Execute `GravadorTablet.exe` (ou `GravadorTablet.ahk`). Um ícone aparece na bandeja do sistema.
4. Use os atalhos:

| Atalho | Ação | Sinal |
|---|---|---|
| `Ctrl` + `Alt` + `G` | Inicia a gravação | 2 bipes + aviso |
| `Ctrl` + `Alt` + `S` | Para a gravação | 1 bipe + aviso |

Os vídeos são salvos em `Área de Trabalho\GravacoesTablet`.

## Estrutura

```
GravadorTablet/
├── GravadorTablet.ahk   # código-fonte (AutoHotkey v2)
├── GravadorTablet.exe   # versão compilada
├── scrcpy/              # scrcpy 4.1 + adb (Apache 2.0)
└── docs/LEIA-ME.txt     # guia original em texto simples
```

## Como funciona

Ao pressionar `Ctrl+Alt+G`, o script executa:

```
scrcpy.exe --record="<pasta>\gravacao_<data>.mp4" --max-size=0
```

Ao pressionar `Ctrl+Alt+S`, fecha a janela do scrcpy, o que finaliza e salva o arquivo.

## Personalização

Edite o `GravadorTablet.ahk`:

- **Pasta de saída:** variável `outDir`
- **Atalhos:** `^!g` (iniciar) e `^!s` (parar). `^` = Ctrl, `!` = Alt
- **Opções do scrcpy:** linha `cmd :=`, por exemplo `--video-bit-rate=16M` ou `--no-audio`

Para gerar um novo `.exe`, compile o `.ahk` com o Ahk2Exe (instalado junto com o AutoHotkey) e mantenha o resultado ao lado da pasta `scrcpy/`.

## Solução de problemas

- **Nada acontece ao gravar:** confira com `scrcpy\adb.exe devices` se o tablet aparece como `device`. Se estiver `unauthorized`, aceite a permissão na tela do tablet.
- **Erro "Não encontrei o scrcpy":** mantenha a pasta `scrcpy/` ao lado do executável.
- **Aviso do SmartScreen:** o `.exe` não é assinado digitalmente. Clique em "Mais informações" > "Executar mesmo assim".
- **Falha no codificador de vídeo:** em alguns aparelhos é preciso indicar um encoder, por exemplo `--video-encoder=c2.android.avc.encoder`. Liste os disponíveis com `scrcpy --list-encoders`.

## Créditos e licença

A gravação é feita pelo [scrcpy](https://github.com/Genymobile/scrcpy) (Genymobile), distribuído sob a licença Apache 2.0, cuja cópia está em `scrcpy/LICENSE.txt`.
