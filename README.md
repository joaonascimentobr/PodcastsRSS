# Podcast App

Este é um aplicativo de podcast para iOS, desenvolvido para praticar habilidades com SwiftUI, AVPlayer, gerenciamento de cache e integração com feeds RSS. O aplicativo permite que o usuário insira a URL de um feed RSS, visualize os detalhes do podcast, reproduza episódios e gerencie downloads.

## Funcionalidades Implementadas

### 1. Carregamento e Parsing do Feed RSS
- **RSSViewModel**: Implementado para gerenciar o carregamento do feed RSS, validação de URLs e estados de erro.
- **RSSService**: Integrado com `FeedKit` para parsing do feed RSS, extraindo informações do podcast, como título, descrição e lista de episódios, além de detalhes como URL do áudio e duração.
- **Cache de Dados do Feed**: Implementado um cache básico para armazenar temporariamente o feed RSS e reduzir a necessidade de downloads repetidos.

### 2. Navegação e Exibição de Dados do Podcast
- **RSSView**: Tela onde o usuário insere a URL do feed RSS e inicia o carregamento do podcast.
- **PodcastDetailsView**: Exibe detalhes do podcast (imagem, título, descrição) e lista de episódios com controle de navegação para o player de áudio.
- **NavigationStack e navigationDestination**: Utilizados para navegar entre `RSSView`, `PodcastDetailsView` e `PlayerView`, mantendo o fluxo de navegação moderno para iOS 16 e superior.

### 3. Reprodução de Áudio e Controle de Player
- **PlayerViewModel**: Gerencia o `AVPlayer`, com funcionalidades de play/pause, skip forward/backward (15 segundos), além de atualização contínua de progresso e formatação de tempo.
- **PlayerView**: Interface do player de áudio com barra de progresso, controles de reprodução e exibição de tempo.

### 4. Cache de Imagens e Áudio
- **Cache de Imagens**: Implementado para carregar imagens do podcast com mais eficiência, evitando download repetido.
- **Armazenamento Local para Episódios Baixados**: Permite ao usuário baixar episódios para reprodução offline. O status de download é indicado ao lado dos episódios.
