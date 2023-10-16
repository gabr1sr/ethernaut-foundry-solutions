include .env

test_all:
	@forge test --fork-url "${SEPOLIA_RPC_URL}" --sender "${PUBLIC_KEY}" -vvv
