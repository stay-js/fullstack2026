# Fullstack 2026

### ‼️ Figyelem!

A Docker Compose és több konténer is használja a `.env` fájlt, ezért az eredetileg a backend (laravel) mappában található `.env.example` fájl a projekt gyökerébe került.

Indítás előtt másold le ezt a fájlt `.env` néven, majd szükség szerint módosítsd a benne található értékeket. A Docker Compose ezt követően automatikusan felcsatolja a megfelelő konténerekhez.

## Indítás

```bash
bash start.sh
```

- Első indítás mindenképpen `start.sh`, utána akár `docker compose up -d`.

## Leállítás

```bash
docker compose stop
```

## Eltávolítás

```bash
docker compose down
```

### Teljes törlés

```bash
docker compose down -v
```

- A `-v` kapcsoló hatására a volume-ok is törlődnek, így az adatbázisban tárolt adatok elvesznek.

## Frontend függőségek kezelése

Amennyiben a frontend csomaghoz új függőséget szeretnél hozzáadni, törölni, frissíteni:

1. A csomag telepítését, eltávolítását, frissítését a host rendszeren végezd el. (`pnpm add` / `pnpm remove`)

2. Ezt követően build-eld újra a frontend imaget:

```bash
docker compose build frontend
```

3. Majd indítsd újra a frontend containert:

```bash
docker compose restart frontend
```
