<template>
  <div class="link">
    <div class="tab">
      <router-link :to="{ name: 'TopPage' }" class="link-list"
        >Top
      </router-link>
      <router-link :to="{ name: 'TaskPage' }" class="link-list"
        >みんなのタスク
      </router-link>
      <router-link :to="{ name: 'MyPage' }" class="link-list"
        >自分のタスク一覧
      </router-link>
      <router-link :to="{ name: 'FightPage' }" class="link-list"
        >自分がいいねしたタスク一覧
      </router-link>
    </div>
  </div>
</template>

<script>
export default {
  name: "LinkList",
  components: {},
};
</script>

<style lang="scss" scoped>
.link {
  width:100%;
  position: fixed;
  z-index: 99;
  top: 0;
  left: 0;
  display: flex;
  padding: 50px 0;
  background-color: rgb(174, 207, 230);
  border-bottom: 3px solid #000000;
  .tab {
    //margin: 10px 100px;
    width: 80%;
    //text-align: center;
    margin: 10px auto;

    .link-list {
      font-size: 20px;
      background-color: aqua;
      margin: 10px;
      padding: 5px;
      border: 2px solid #000000;
      border-radius: 5px;
      text-decoration: none;
    }
    .link-list:hover {
      background-color: rgb(159, 159, 231);
    }
  }
}
</style>
