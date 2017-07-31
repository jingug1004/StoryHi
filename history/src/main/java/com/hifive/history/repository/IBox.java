package com.hifive.history.repository;

import java.util.List;
import java.util.Map;

public interface IBox {
	public int hi_insertMap(Map<String, Object> map);
	public void hi_updateFile(Map<String, Object> map) throws Exception;
	public void hi_deleteFileList(Map<String, Object> map) throws Exception;
	public Map<String, Object> hi_selectFileInfo(Map<String, Object> map) throws Exception;
	public List<Map<String, Object>> hi_selectList(Map<String, Object> dto) throws Exception;
}
