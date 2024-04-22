<template>
  <div class="top-page">
    <div class="body">
      <div class="title">トップページ</div>
      <div class="tab">
        <router-link class="link-list" :to="{ name: 'TopPage' }">
          Top
        </router-link>
        <router-link
          class="link-list"
          :to="{ name: 'SignUp' }"
          v-if="this.$store.getters.isLoggedIn == false"
        >
          新規登録
        </router-link>
        <router-link
          class="link-list"
          :to="{ name: 'TaskPage' }"
          v-if="this.$store.getters.isLoggedIn"
        >
          タスク
        </router-link>
        <router-link
          class="link-list"
          :to="{ name: 'SignIn' }"
          v-if="this.$store.getters.isLoggedIn == false"
        >
          サインイン
        </router-link>
        <router-link class="link-list" :to="{ name: 'SamplePage' }"
          >サンプルページを見る</router-link
        >
        <p>userIdの確認: {{ this.$store.getters.userId }}</p>
        <p>ログインの確認: {{ this.$store.getters.isLoggedIn }}</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "TopPage",
  data() {
    return {
      sampleItems: [],
      inputText: "",
    };
  },
};
</script>

<style lang="scss" scoped>
.top-page {
  background-color: rgb(193, 238, 235);
  //background-size: cover;
  min-height: 1200px;
  padding: 5% 0px;

  .body {
    width: 80%;
    //text-align: center;
    margin: 0px auto;
  }

  .title {
    font-size: 36px;
    font-weight: bold;
    margin: 30px;
  }

  .tab {
    padding: 10px;
    margin: 30px;
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
