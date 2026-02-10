import { get } from "../../utils/request";

// Skill信息
export interface SkillInfo {
  name: string;
  description: string;
}

// 获取预装Skills列表；skills_available 为 false 表示沙箱未启用，前端应隐藏/禁用 Skills 配置
export function listSkills() {
  return get('/api/v1/skills') as Promise<{ data: SkillInfo[]; skills_available?: boolean }>;
}
