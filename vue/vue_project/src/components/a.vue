<template>
  <div class="sample-item-card">
    <div class="task-card-name">{{ taskCard.name }}</div>
    <div class="task-card-text">{{ taskCard.text }}</div>
    <input type="checkbox" id="checkbox-name">
    <label for="checkbox-name">チェックボックス</label>
  </div>
</template>

<script>
export default {
  name: 'ExampleCard',
  components: {},
  props: {
    sampleItem: {
      type: Object,
      default: () => {},
    },
  },
}
</script>


<style lang="scss" scoped>
.sample-item-card {
  position: relative;
  width: 300px;
  height: min-content;
  min-height: 100px;
  background-color: white;
  padding: 24px;
  box-sizing: border-box;
  border: 1px solid #eee;
  border-radius: 8px;
  box-shadow: 2px 2px 4px #bbb;
  cursor: pointer;

  &-text {
    font-size: 16px;
    font-weight: bold;
    user-select: none;
  }

  &:hover {
    right: 4px;
    bottom: 4px;
  }
}
</style>
