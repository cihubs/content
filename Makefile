# cihubs/content — operaciones HyperFrames de decks
# Formato de targets: env-destino-verbo (p. ej. local-deck-check)
# Cambiar de deck: make local-deck-check DECK=otro-deck

DECK ?= acompanamiento-colegiales
DECK_DIR := decks/$(DECK)
COMP_DIR := $(DECK_DIR)/composition
HF := npx --yes hyperframes@0.8.111
LIVE_BASE := https://cihubs.github.io/content/decks/$(DECK)

local-deck-check: ## Lint+runtime+layout+motion+contrast (corre dentro de composition/)
	cd $(COMP_DIR) && $(HF) check

local-deck-preview: ## Preview persistente para revisión (verificar con local-deck-status, cerrar con local-deck-stop)
	cd $(DECK_DIR) && $(HF) preview --background

local-deck-status: ## Verificar que el preview persistente escucha
	cd $(DECK_DIR) && $(HF) preview --status

local-deck-stop: ## Detener el preview persistente
	cd $(DECK_DIR) && $(HF) preview --stop

local-deck-render: ## Renderizar la composición a MP4
	cd $(DECK_DIR) && $(HF) render

local-deck-publish: ## Publicar y obtener link compartible
	cd $(DECK_DIR) && $(HF) publish

prod-deck-verify: ## Verificar deploy vivo en Pages (200s + conteo de escenas)
	curl -s -o /dev/null -w "deck:%{http_code}\n" $(LIVE_BASE)/
	curl -s $(LIVE_BASE)/composition/index.html | grep -c "scene-"
