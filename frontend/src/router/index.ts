import { createRouter, createWebHashHistory, RouteRecordRaw } from "vue-router";
import AddressSearch from "../components/AddressSearch.vue";

const routes: Array<RouteRecordRaw> = [
  {
    path: "/",
    name: "Search",
    component: AddressSearch,
  },
];

const router = createRouter({
  history: createWebHashHistory(),
  routes,
});

export default router;
