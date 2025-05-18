pnpm --filter snaprtc install
pnpm --filter snaprtc run build

pnpm --filter docs install
pnpm --filter docs run build

firebase deploy --only hosting
