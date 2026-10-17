# TMS FNC Cloud Translation - Exemplos

Exemplo de uso do componente **TTMSFNCCloudTranslation**, do [TMS FNC Cloud Pack](https://www.tmssoftware.com/site/tmsfnccloudpack.asp), para traduzir textos em aplicações Delphi (VCL, FMX e TMS WEB Core) usando serviços de tradução na nuvem.

## Serviços suportados

Os recursos de tradução deste exemplo podem ser utilizados com os seguintes provedores:

| Provedor | Onde gerar a API key |
|---|---|
| **Google** (Cloud Translation API) | https://console.cloud.google.com |
| **Microsoft** (Azure AI Translator) | https://portal.azure.com |
| **IBM** (Language Translator) | https://cloud.ibm.com |
| **DeepL** | https://www.deepl.com/pro-api |

Para trocar de provedor, basta alterar o serviço configurado no componente e informar a chave correspondente. O restante do código continua igual.

## Como obter as API keys

### Microsoft (Azure AI Translator)

1. Acesse https://portal.azure.com e faça login com sua conta Microsoft.
2. Se ainda não tiver uma assinatura, vá em **Assinaturas → + Adicionar** e crie uma (conta gratuita ou pagamento conforme o uso).
3. Na barra de busca do topo, digite **Tradutor** (ou *Translator*, com o portal em inglês) e abra o item **Tradutor** em *Marketplace*.
4. Clique em **Criar** e preencha:
   - **Grupo de recursos:** crie um novo (ex.: `demo-test`)
   - **Região:** **Global**
   - **Nome:** um nome único (ex.: `tradutor-demo`)
   - **Tipo de preço:** **F0 (Free)**
5. Clique em **Revisar + criar** e depois em **Criar**.
6. Abra o recurso criado e vá em **Gerenciamento de Recursos → Chaves e Ponto de Extremidade**.
7. Copie a **CHAVE 1**.

> Se o recurso for criado em uma região específica em vez de **Global**, a API exige que a região seja informada em cada chamada. Para evitar erros 401, prefira a região Global.

### Google (Cloud Translation API)

1. Acesse https://console.cloud.google.com e crie ou selecione um projeto.
2. Vá em **APIs e serviços → Biblioteca**, procure **Cloud Translation API** e clique em **Ativar**.
3. Vincule uma conta de faturamento ao projeto (exigido pelo Google, mesmo dentro da cota gratuita).
4. Vá em **APIs e serviços → Credenciais → Criar credenciais → Chave de API**.
5. (Recomendado) Restrinja a chave para ser usada apenas pela *Cloud Translation API*.

### IBM (Language Translator)

1. Acesse https://cloud.ibm.com e faça login.
2. No catálogo, crie uma instância do serviço de tradução.
3. Em **Credenciais de serviço**, copie a **API key** e a **URL** do serviço.

### DeepL

1. Crie uma conta de API em https://www.deepl.com/pro-api (há plano gratuito).
2. Em **Conta → Chaves de API**, copie a chave.

## 🏷️ Cupom de desconto
- Use este cupom exclusivo e tenha 30% de desconto em qualquer produto da TMS:
```
2026Code4Delphi30
```

## Links úteis
|[Site oficial](https://www.tmssoftware.com/site/tmsfnccloudpack.asp)|[Documentação](https://doc.tmssoftware.com/fnc/cloudpack/translation)|
|--|--|


## Vídeos de demonstração
- Em breve

<br>

## Multiplataforma
<img width="524" height="124" alt="VCL-FMX-Web-FNC" src="https://github.com/user-attachments/assets/17b23899-0e26-4901-810e-f9a03e38deae" />

<br>

## 📞 Contatos
[![Telegram](https://img.shields.io/badge/Telegram-Join-blue?logo=telegram)](https://t.me/Code4Delphi)
[![YouTube](https://img.shields.io/badge/YouTube-Join-red?logo=youtube&logoColor=red)](https://www.youtube.com/@code4delphi)
[![Instagram](https://img.shields.io/badge/Intagram-Follow-red?logo=instagram&logoColor=pink)](https://www.instagram.com/code4delphi/)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue)](https://www.linkedin.com/in/cesar-cardoso-dev)
[![Blog](https://img.shields.io/badge/Blog-Code4Delphi-F00?logo=delphi)](https://code4delphi.com.br/blog/)
[![Course](https://img.shields.io/badge/Course-Delphi-F00?logo=delphi)](https://code4delphi.github.io/ia-devs-delphi-lazarus/)
[![E-mail](https://img.shields.io/badge/E--mail-Send-yellowgreen?logo=maildotru&logoColor=yellowgreen)](mailto:contato@code4delphi.com.br)


