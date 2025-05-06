const state = {
  selectedSender: [],
  allLists: [],
  sendingStrategy: 'roundrobin'
};

const mutations = {
  updateSenders(state, { selectedSender, sendingStrategy, allLists }) {
    if (selectedSender) state.selectedSender = selectedSender;
    if (sendingStrategy) state.sendingStrategy = sendingStrategy;
    if (allLists) state.allLists = allLists;
  }
};

const actions = {
  initState({ commit }) {
    // Initialize state from localStorage if needed
    const savedState = localStorage.getItem('campaignState');
    if (savedState) {
      commit('updateSenders', JSON.parse(savedState));
    }
  },
  clearState({ commit }) {
    commit('updateSenders', {
      selectedSender: [],
      sendingStrategy: 'roundrobin',
      allLists: []
    });
    localStorage.removeItem('campaignState');
  }
};

export default {
  namespaced: true,
  state,
  mutations,
  actions
}; 