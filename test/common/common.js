function accounts(rpc_accounts) {
	return {
		DEPLOY_OPERATOR: rpc_accounts[0],
		MSIG_OWNER: rpc_accounts[1],
		ACCT_ADMIN: rpc_accounts[2],

		USER1: rpc_accounts[3],
		USER2: rpc_accounts[4],
		USER3: rpc_accounts[5],
		USER4: rpc_accounts[6],
		USER5: rpc_accounts[7],
	};
}

module.exports = {
	accounts: accounts,
};
