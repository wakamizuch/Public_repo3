import Vue from "vue";
import VueRouter from "vue-router";
import TopPage from "@/views/TopPage";
import SamplePage from "@/views/SamplePage";
import SignUp from "@/views/SignUp";
import SignIn from "@/views/SignIn";
import TaskPage from "@/views/TaskPage";
import MyPage from "@/views/MyPage";
import OtherPage from "@/views/OtherPage";
import FightPage from "@/views/FightPage";
import store from "@/store/index.js";
import { START_LOCATION } from "vue-router";

Vue.use(VueRouter);

function denyIsNotLoggedInAccess(to, from, next) {
  if (!store.getters.isLoggedIn) {
    // ログインしていない場合
    alert("ログインしていません");
    next({ name: "TopPage" }); // '/hoge' へリダイレクトする
  }
  next();
}

function denyIsLoggedInAccess(to, from, next) {
  if (store.getters.isLoggedIn) {
    // ログイン中です
    console.log("ダメらしいです");
    alert("ログイン中です");
    next({ name: "TopPage" }); // '/hoge' へリダイレクトする
  }
  next();
}
const routes = [
  {
    path: "/",
    name: "TopPage",
    component: TopPage,
  },
  {
    path: "/sample",
    name: "SamplePage",
    component: SamplePage,
  },
  {
    path: "/signup",
    name: "SignUp",
    component: SignUp,
    beforeEnter: denyIsLoggedInAccess,
  },
  {
    path: "/signin",
    name: "SignIn",
    component: SignIn,
    beforeEnter: denyIsLoggedInAccess,
  },

  {
    path: "/tasks",
    name: "TaskPage",
    component: TaskPage,
    beforeEnter: denyIsNotLoggedInAccess,
  },

  {
    path: "/my_page",
    name: "MyPage",
    component: MyPage,
    beforeEnter: denyIsNotLoggedInAccess,
  },
  {
    path: "/other_page/:userId",
    name: "OtherPage",
    component: OtherPage,
    beforeEnter: denyIsNotLoggedInAccess,
  },

  {
    path: "/fight_page",
    name: "FightPage",
    component: FightPage,
    beforeEnter: denyIsNotLoggedInAccess,
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,

  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition;
    } else {
      return { x: 0, y: 0 };
    }
  },
});

export default router;
