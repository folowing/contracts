// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.5.0;

interface Truebit {
  event BlockLimitError(bytes32 taskID);
  event EndCommitChallengePeriod(bytes32 taskID);
  event EndRevealIntentPeriod(bytes32 taskID, uint256 numVerifiers);
  event JackpotTriggered(bytes32 taskID);
  event ReceivedJackpot(bytes32 taskID, address receiver, address intended, uint256 amount);
  event RewardPaid(bytes32 taskID, uint256 solverAmount, uint256 ownerAmount, address solver, address owner);
  event SlashedDeposit(bytes32 taskID, address account, address opponent, uint256 amount);
  event SolutionCommitted(bytes32 taskID);
  event SolutionRevealed(bytes32 taskID, bytes32 solution0);
  event SolverSelected(bytes32 indexed taskID, address solver, bytes32 randomBitsHash);
  event TaskCreated(bytes32 taskID, uint256 minDeposit, uint256 reward, uint256 tax, uint256 blockLimit);
  event TaskFinalized(bytes32 taskID, bytes32[] files);
  event TaskTimeout(bytes32 taskID, uint256 refund);
  event VerificationGame(bytes32 taskID, bytes32 gameID, address indexed solver, address currentChallenger);

  function BASIC_TIMEOUT() external view returns (uint256);
  function BURN_RATE() external view returns (uint256);
  function LICENSE_FEE() external view returns (uint256);
  function PLATFORM_FEE_SOLVER() external view returns (uint256);
  function PLATFORM_FEE_TASK_GIVER() external view returns (uint256);
  function SLASH_RATE() external view returns (uint256);
  function TASKS_PER_LICENSE() external view returns (uint256);
  function TRUburnBox() external view returns (uint256);
  function bonusTable() external view returns (uint256);
  function buyLicense(address account) external payable;
  function canClaimAbandonedJackpots(bytes32 taskID) external view returns (bool);
  function canRunVerificationGame(bytes32 taskID) external view returns (bool);
  function challenges(bytes32) external view returns (uint256);
  function commitChallenge(bytes32 hash) external;
  function commitSolution(bytes32 taskID, bytes32 solutionHash0) external payable;
  function createTaskId(bytes32 bundleId, uint256 minDeposit, uint256 solverReward, uint256 verifierTax, uint256 ownerFee, uint256 blockLimit) external returns (bytes32);
  function endCommitChallengePeriod(bytes32 taskID) external returns (bool);
  function endRevealIntentPeriod(bytes32 taskID) external returns (bool);
  function endSolverSelectionPeriod(bytes32 taskID) external returns (bool);
  function finalizeTask(bytes32 taskID) external returns (bool);
  function getBondedDeposit(bytes32 taskID, address account) external view returns (uint256);
  function getSolverUploads(bytes32 taskID) external view returns (bytes32[] memory);
  function getUnbondedDeposit(address account) external view returns (uint256);
  function getUploadNames(bytes32 taskID) external view returns (bytes32[] memory);
  function getUploadTypes(bytes32 taskID) external view returns (uint8[] memory);
  function getVerifierInfo(bytes32 taskID, uint256 index) external view returns (uint256, address, bool, bool, bool);
  function getVerifierList(bytes32 taskID) external view returns (address[] memory);
  function initialize(address _tru, address _Purchase, address _disputeResolutionLayer, address _fs) external;
  function makeDeposit(uint256 _deposit) external returns (uint256);
  function numLicenses() external view returns (uint256);
  function numTasks() external view returns (uint256);
  function prematureReveal(bytes32 taskID, uint256 originalRandomBits) external;
  function receiveJackpotPayment(bytes32 taskID, uint256 index) external returns (uint256);
  function registerForTask(bytes32 taskID, bytes32 randomBitsHash) external;
  function reportBlockLimitError(bytes32 id, uint8 v, bytes32 r, bytes32 s) external;
  function requireFile(bytes32 id, bytes32 hash, uint8 fileType) external;
  function revealIntent(bytes32 taskID, bytes32 solution) external;
  function revealSolution(bytes32 taskID, bytes32 originalRandomBits, bytes32 codeHash, bytes32 sizeHash, bytes32 nameHash, bytes32 dataHash) external;
  function runVerificationGame(bytes32 taskID, uint256 index) external;
  function setParameters() external;
  function solverLoses(bytes32 taskID) external returns (bool);
  function sqrt(uint256 x) external pure returns (uint256 y);
  function submitTask(bytes32 id) external payable;
  function subsidyPool() external view returns (uint256);
  function taskParameters(bytes32) external view returns (bytes32 bundleId, uint256 minDeposit, uint256 reward, uint256 tax, uint256 ownerFee, uint256 blockLimit, address owner, address submitter, address selectedSolver, bytes32 currentGame, uint8 state);
  function taskTimeout(bytes32 taskID) external returns (bool);
  function unbondDeposit(bytes32 taskID) external returns (uint256);
  function uploadFile(bytes32 id, uint256 num, bytes32 file_id, bytes32[] memory name_proof, bytes32[] memory data_proof, uint256 file_num) external returns (bool);
  function withdrawDeposit(uint256 amount) external returns (uint256);
  function withdrawEth() external;
}

interface FileSystem {
  event CreatedFile(bytes32 id, bytes32 root);

  function addContractFile(string memory name, uint256 size, address _address, bytes32 root, uint256 nonce) external returns (bytes32);
  function addIpfsFile(string memory name, uint256 size, string memory hash, bytes32 root, uint256 nonce) external returns (bytes32);
  function addToBundle(uint256 nonce, bytes32 fid) external;
  function bundles(bytes32) external view returns (bytes32 codeFileId, bytes32 init);
  function calculateId(uint256 nonce) external view returns (bytes32);
  function containsNameHash(bytes32 bid, bytes32 hash) external view returns (bool);
  function createFileFromArray(string memory name, uint256 nonce, bytes32[] memory arr, uint256 sz) external returns (bytes32);
  function createFileFromBytes(string memory name, uint256 nonce, bytes memory arr) external returns (bytes32);
  function finalizeBundle(uint256 nonce, bytes32 codeFileID) external returns (bytes32);
  function forwardData(bytes32 id, address a) external;
  function getBytesData(bytes32 id) external view returns (bytes32[] memory);
  function getCodeFileId(bytes32 bid) external view returns (bytes32);
  function getCodeType(bytes32 id) external view returns (uint8);
  function getContractAddress(bytes32 id) external view returns (address);
  function getContractCode(bytes32 id) external view returns (bytes memory);
  function getFileList(bytes32 bid) external view returns (bytes32[] memory);
  function getFileType(bytes32 id) external view returns (uint256);
  function getFormattedBytesData(bytes32 id) external view returns (bytes memory);
  function getInitialHash(bytes32 bid) external view returns (bytes32);
  function getIpfsHash(bytes32 id) external view returns (string memory);
  function getName(bytes32 id) external view returns (string memory);
  function getNameHash(bytes32 id) external view returns (bytes32);
  function getRoot(bytes32 id) external view returns (bytes32);
  function getSize(bytes32 id) external view returns (uint256);
  function hashName(string memory name) external pure returns (bytes32);
  function initialize() external;
  function setCodeRoot(uint256 nonce, bytes32 codeRoot, uint8 codeType, uint8 stackSize, uint8 memorySize, uint8 globalsSize, uint8 tableSize, uint8 callSize) external;
  function vmParameters(bytes32) external view returns (bytes32 codeRoot, uint8 codeType, uint8 stackSize, uint8 memorySize, uint8 globalsSize, uint8 tableSize, uint8 callSize);
}

interface TRU {
  event Approval(address indexed owner, address indexed spender, uint256 value);
  event Paused(address account);
  event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender);
  event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender);
  event Transfer(address indexed from, address indexed to, uint256 value);
  event Unpaused(address account);

  function DEFAULT_ADMIN_ROLE() external view returns (bytes32);
  function MINTER_ROLE() external view returns (bytes32);
  function PAUSER_ROLE() external view returns (bytes32);
  function allowance(address owner, address spender) external view returns (uint256);
  function approve(address spender, uint256 amount) external returns (bool);
  function balanceOf(address account) external view returns (uint256);
  function burn(uint256 amount) external;
  function burnFrom(address account, uint256 amount) external;
  function decimals() external view returns (uint8);
  function decreaseAllowance(address spender, uint256 subtractedValue) external returns (bool);
  function getRoleAdmin(bytes32 role) external view returns (bytes32);
  function getRoleMember(bytes32 role, uint256 index) external view returns (address);
  function getRoleMemberCount(bytes32 role) external view returns (uint256);
  function grantRole(bytes32 role, address account) external;
  function hasRole(bytes32 role, address account) external view returns (bool);
  function increaseAllowance(address spender, uint256 addedValue) external returns (bool);
  function initialize(string memory _name, string memory _symbol) external;
  function mint(address to, uint256 amount) external;
  function name() external view returns (string memory);
  function pause() external;
  function paused() external view returns (bool);
  function renounceRole(bytes32 role, address account) external;
  function revokeRole(bytes32 role, address account) external;
  function symbol() external view returns (string memory);
  function totalSupply() external view returns (uint256);
  function transfer(address recipient, uint256 amount) external returns (bool);
  function transferAdmin(address newAdmin) external;
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
  function unpause() external;
}

interface Purchase {
  event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender);
  event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender);

  function DEFAULT_ADMIN_ROLE() external view returns (bytes32);
  function IPFS_ADMIN() external view returns (bytes32);
  function OPEX_COST() external view returns (uint256);
  function SOLVER() external view returns (bytes32);
  function SOLVER_ADMIN() external view returns (bytes32);
  function THETA() external view returns (uint256);
  function addSolver(address account) external returns (bool);
  function buyTRU(uint256 numTRU) external payable returns (uint256);
  function donateToReserve() external payable;
  function getPurchasePrice(uint256 numTRU) external view returns (uint256);
  function getRetirePrice(uint256 numTRU) external view returns (uint256);
  function getRoleAdmin(bytes32 role) external view returns (bytes32);
  function getRoleMember(bytes32 role, uint256 index) external view returns (address);
  function getRoleMemberCount(bytes32 role) external view returns (uint256);
  function grantRole(bytes32 role, address account) external;
  function hasRole(bytes32 role, address account) external view returns (bool);
  function initialize(address _tru, address _admin) external;
  function opex() external view returns (uint256);
  function renounceRole(bytes32 role, address account) external;
  function reserve() external view returns (uint256);
  function revokeRole(bytes32 role, address account) external;
  function sellTRU(uint256 numTRU) external returns (uint256);
  function setOpexCost(uint256 newCost) external;
  function setParameters() external;
  function withdrawETH() external;
}
