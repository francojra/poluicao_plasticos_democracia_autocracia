
# Poluição por plásticos em países democratas e autocratas ---------------------------------------------------------------------------------
# Autoria do script: Jeanne Franco ---------------------------------------------------------------------------------------------------------
# Data: 07/12/22 ---------------------------------------------------------------------------------------------------------------------------
# Referência: https://ourworldindata.org/plastic-pollution ---------------------------------------------------------------------------------

# Sobre os dados ---------------------------------------------------------------------------------------------------------------------------

### O primeito plástico sintético - Bakelite - foi produzido em 1907, marcando o início
### da indústria de plástico global. Entretanto, o rápido crescimento na produção de plástico
### global não foi realizado até os anos de 1950. Ao longo dos próximos 70 anos, a produção
### anual de plásticos aumentou quase 230 vezes para 460 milhões de toneladas em 2019.

### Poluição por plásticos está tendo um impacto negativo sobre o oceano e a saúde da fauna
### selvagem.

### Países de alta renda geram mais resíduos de plástico por pessoa.

### A maior parte dos plásticos acabam em oceanos e vem de rios em países de média e baixa renda.
### Isso ocorre devido a esses países tenderem a ter mal orientado destino do lixo, já os
### países de alta renda apresentam o descarte correto do lixo.

### Os sistemas de gestão de resíduos em todo o mundo são fundamentais para reduzir a 
### poluição plástica.

### Cerca de 20% de todo lixo plástico nos oceanos vem de fontes marinhas. Os outros 80%
### da terra. Em algumas regiões, fontes marinhas dominam: mais que 80% no Grande Mancha 
### de Lixo do Pacífico (GPGP) vem de redes marinhas, cordas e linhas de pesca.

### Plástico é o único material com muitos benefícios: ele é barato, versátil, de baixo
### peso e resistente. Isso torna a disponibilidade do material para muitas funções. Ele
### também pode promover benefícios ambientais: ele promove um crítico papel na conservação
### da qualidade dos alimentos, segurança e redução do desperdício alimentar. O trade-off 
### entre plásticos e substitutos (ou proibições completas) é complexo e pode criar impacto
### negativo sobre o meio ambiente.

# Carregar pacotes -------------------------------------------------------------------------------------------------------------------------

library(tidyverse)
library(cols4all)
library(hrbrthemes)
library(ggthemes)

# Carregar dados ---------------------------------------------------------------------------------------------------------------------------

pol_plas <- read.csv("plastic-pollution.csv")
view(pol_plas)
names(pol_plas)

# Manipular dados --------------------------------------------------------------------------------------------------------------------------

pol_plas <- pol_plas %>%
  select(-Code) %>%
  rename(res_plas = Mismanaged.plastic.waste.to.ocean.per.capita..kg.per.year.) %>%
  view()

pol_plas1 <- pol_plas %>%
  filter(Entity %in% c("United States", "Japan", "Germany",
                       "Cuba", "China", "North Korea")) %>%
  view()

pol_plas2 <- pol_plas %>%
  filter(Entity %in% c("United States", "China", "Brazil")) %>%
  view()

# Gráficos ---------------------------------------------------------------------------------------------------------------------------------

c4a("safe", 5)

ggplot(pol_plas1, aes(x = fct_reorder(Entity, res_plas), 
                      y = res_plas, fill = Entity)) +
  geom_col() +
  scale_fill_manual(values = c("#88CCEE", "#CC6677",
                               "#DDCC77", "#117733",
                               "#332288")) +
  scale_y_continuous(expand = expansion(mult = c(0,0))) +
  scale_x_discrete(labels = c("Alemanha", "Coreia do Norte", "Estados Unidos",
                              "Japão", "China")) +
  labs(x = "Países", y = "Resíduos de plástico (kg)\n gerados em 2019") +
  theme_ipsum(axis_text_size = 14, axis_title_size = 16) +
  theme(legend.position = "none", axis.text = element_text(color = "black")) 

ggplot(pol_plas2, aes(x = fct_reorder(Entity, res_plas), 
                      y = res_plas, fill = Entity)) +
  geom_col() +
  scale_fill_manual(values = c('#1B9E77', '#999999','#E69F00')) +
  scale_x_discrete(labels = c("Estados Unidos", "China", "Brasil")) +
  labs(x = "Países", y = "Resíduos de plástico (kg)\n gerados em 2019") +  
  theme_light() +
  theme(legend.position = "none",
        axis.title = element_text(size = 18),
        axis.text = element_text(color = "black", size = 15),
        legend.text = element_text(size = 12))
