require('babel-register');
require('babel-polyfill');

import EVMRevert from "../zeppelin/test/helpers/EVMRevert";
import {accounts} from './common/common';

let chai = require('chai');
let assert = chai.assert;
let Promise = require('bluebird');

const Collectibles = artifacts.require("../contracts/Collectibles.sol");

contract('Collectibles', function (rpc_accounts) {

	let ac = accounts(rpc_accounts);

	let pGetBalance = Promise.promisify(web3.eth.getBalance);
	let pSendTransaction = Promise.promisify(web3.eth.sendTransaction);

	let collectibles = null;

	it('should be able to deploy the Collectibles contract and set initial state', async function () {
		collectibles = await Collectibles.new(
			ac.MSIG_OWNER,
			ac.ACCT_ADMIN,
			{from: ac.DEPLOY_OPERATOR, gas: 7000000}
		);

		console.log("collectibles.address= " +collectibles.address);
	});

	it('should be able mint a collectible token', async function () {

		let ts = Math.floor(Date.now()/1000);
		console.log('ts= '+ts);
		let hash = web3.sha3('user1 was present at bcg2018');
		console.log('hash= '+hash);

		let rec = await collectibles.mint(ac.USER1, hash, ts, {from: ac.ACCT_ADMIN});
		console.log(JSON.stringify(rec, null, 2))
	});

});
