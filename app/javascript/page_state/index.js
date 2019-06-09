export default (stateArray, defaultState) => {
  const stateObject = {};
  stateObject.states = {};
  stateArray.forEach((state) => {
    if (state !== defaultState) {
      stateObject.states[state] = false;
    } else {
      stateObject.states[state] = true;
    }
  });

  stateObject.currentState = function getPageState() {
    return Object.keys(this.states).find(state => this.states[state] === true);
  };

  stateObject.setState = function setPageState(newActiveState) {
    Object.keys(this.states).forEach((state) => {
      if (state !== newActiveState) {
        this.states[state] = false;
      } else {
        this.states[state] = true;
      }
    });
  };

  return stateObject;
};
