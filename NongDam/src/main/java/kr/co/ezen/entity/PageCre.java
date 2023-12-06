package kr.co.ezen.entity;

import lombok.Data;

@Data
public class PageCre {
	//231205
	//페이징 처리를 생성하는 클래스.
	//수정하지 말아주세요!!
	
	private Criteria cri; //kr.co.ezen.entity.Criteria
	private int totalCount; //총게시글수
	private int startPage; //시작 페이지 번호
	private int endPage; //끝 페이지 번호
	private boolean prev; //이전버튼
	private boolean next; //다음버튼
	private int showPageNum = 10; //하단에 보여질 페이지
	
	public void createPage() {
		//1. 화면에 보여질 마지막 페이지 번호
		endPage = (int) (Math.ceil(cri.getPage() / (double) showPageNum) * showPageNum);
		
		//2. 시작 페이지 번호 
		startPage = (endPage - showPageNum) + 1;
		
		if(startPage<=0) {
			startPage=1;
		}
		
		//3. 전체 마지막 페이지 계산
		int tmpPage = (int) (Math.ceil((totalCount) / (double) cri.getPerPageNum()));
		
		//4. 화면에 보여질 마지막 페이지 체크
		if(tmpPage<endPage) {
			//마지막 번호가 9인데 10이 보이면 안됨.
			//따라서 9를 마지막 페이지로 설정해야함
			
			endPage = tmpPage;
		}
		
		//5.이전페이지 버튼이 존재해야하는지 아닌지
		//삼항조건연산자
		prev = (startPage==1)?false:true;
		
		//6. 다음페이지
		//마지막페이지는 다음 버튼이 없어야 함
		next = (endPage<tmpPage)?true:false;

	}
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		createPage();
	}
}
